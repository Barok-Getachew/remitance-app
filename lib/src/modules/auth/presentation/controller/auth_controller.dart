import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:remitance/src/core/routes/app_pages.dart';

import '../../../../common/constants/keys.dart';
import '../../../../core/enum/box_types.dart';
import '../../../../utils/services/local_auth/local_auth.dart';
import '../../../../core/error/error.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/signup_usecase.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
// Text Editing Controller
  final loginEmailController = TextEditingController();
  final loginpasswordContoller = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordContoller = TextEditingController();
  final signupConfirmPasswordContoller = TextEditingController();
  final signupfullNameContoller = TextEditingController();
  final RxBool isVisible = false.obs;
  final RxBool isSignUpPassVisible = false.obs;
  final RxBool isSignUpConfVisible = false.obs;
  LocalAuth localAuth = LocalAuth();
  AuthController({
    required this.loginUseCase,
    required this.registerUseCase,
  });

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Basic input validation
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar(
          'Error',
          "No field can be empty",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      await Future.delayed(Duration(seconds: 2));

      final user = await loginUseCase.execute(email, password);

      if (user != null) {
        final Box settingsBox = Hive.box(BoxType.settings.name);
        final bool isBiometricEnabled =
            settingsBox.get(biometricKey, defaultValue: false);

        if (isBiometricEnabled) {
          bool biometricSuccess = await localAuth.authenticateWithBiometrics();

          if (biometricSuccess) {
            currentUser.value = user;
            Get.toNamed(
              AppRoutes.home,
              arguments: user,
            );
          } else {
            Get.snackbar(
              'Authentication Failed',
              'Biometric authentication is required to access the app.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          // Biometric is off → Allow login without biometric
          currentUser.value = user;
          Get.toNamed(
            AppRoutes.home,
            arguments: user,
          );
        }
      } else {
        errorMessage.value = 'User not found with email: $email';
        Get.snackbar(
          'Login Failed',
          errorMessage.value,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on OneorMoreFieldIsInvalidException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = 'Login failed: ${e.toString()}';
      Get.snackbar(
        'Login Failed',
        errorMessage.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Register new user
  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
    double initialBalance = 0.0,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await Future.delayed(Duration(seconds: 2));

      final newUser = UserEntity(
        id: '',
        name: name,
        email: email,
        balance: initialBalance,
      );

      if (password.isEmpty ||
          confirmPassword.isEmpty ||
          name.isEmpty ||
          email.isEmpty) {
        Get.snackbar(
          'Ereor',
          "No Field can not be empty",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (password != confirmPassword) {
        Get.snackbar(
          'Password',
          "Password and Confirm password must be the same",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return;
      }

      final result = await registerUseCase.execute(newUser, password);

      if (result) {
        Get.snackbar(
          "Succes",
          "User Registered Succesfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(AppRoutes.login);
        signupPasswordContoller.clear();
        signupEmailController.clear();
        signupConfirmPasswordContoller.clear();
        signupfullNameContoller.clear();
      }
    } on UserAlreadyExistsException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    } catch (e) {
      errorMessage.value = 'Registration failed: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void clearErrors() {
    errorMessage.value = '';
  }
}
