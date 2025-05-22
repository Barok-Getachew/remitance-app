import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:remitance/src/common/constants/keys.dart';
import 'package:remitance/src/modules/Transaction/domain/Entity/transaction_entity.dart';
import 'package:remitance/src/modules/Transaction/domain/usecase/get_transactions.dart';
import 'package:remitance/src/modules/Transaction/domain/usecase/send_money_usecase.dart';
import 'package:remitance/src/modules/Transaction/domain/usecase/topup_usecase.dart';
import 'package:remitance/src/modules/auth/domain/entity/user_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/controller/hivecontroller.dart';
import '../../../../core/enum/box_types.dart';
import '../../../../core/enum/payment_type.dart';
import '../../../../core/enum/transaction_type.dart';
import '../../../../utils/services/local_auth/local_auth.dart';

class HomeController extends GetxController {
  late final UserEntity user;
  final TopUpUseCase topUpUseCase;
  final SendMoneyUsecase sendMoneyUsecase;
  final GetTransactionsUseCase getTransactionsUseCase;
  @override
  void onInit() {
    super.onInit();
    user = Get.arguments as UserEntity;
    getTransactions();
  }

  final hiveController = Get.find<HiveController>();

  HomeController(
      {required this.sendMoneyUsecase,
      required this.getTransactionsUseCase,
      required this.topUpUseCase});

  RxList<TransactionEntity> transactions = <TransactionEntity>[].obs;

  // Common input fields
  final RxDouble topupAmount = 0.0.obs;
  final RxDouble sendAmount = 0.0.obs;
  final RxString topUpsource = ''.obs;
  final RxString description = ''.obs;
  final Rx<TransactionType> selectedType = TransactionType.topup.obs;
  final RxBool isLoading = false.obs;
  RxInt currentPageIndex = 0.obs;
  final RxInt visibleTransactionCount = 3.obs;
  LocalAuth localAuth = LocalAuth();
  // Text Editing Controller
  final receiverEmail = TextEditingController();

  void toggleShowAll(int total) {
    if (visibleTransactionCount.value == total) {
      visibleTransactionCount.value = 3;
    } else {
      visibleTransactionCount.value = total;
    }
  }

  // transaxction

  Future<void> submitTransaction() async {
    if (!(await _shouldProceedWithBiometric())) return;
    if (topupAmount.value <= 0 || topUpsource.value.isEmpty) {
      Get.snackbar("Error", "Amount and source/destination required");
      return;
    }

    isLoading.value = true;

    final tx = TransactionEntity(
      id: const Uuid().v4(),
      amount: topupAmount.value,
      source: topUpsource.value,
      type: selectedType.value.name,
      description: description.value,
      date: DateTime.now(),
      currentUserEmail: user.email,
      receiverUserEmail: '',
    );

    final result = await topUpUseCase.repository.addTransaction(tx);
    if (result) {
      getTransactions();
      isLoading.value = false;
      Get.back();
      Get.snackbar(
        'Success',
        "${selectedType.value.name.capitalizeFirst} completed",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void resetForm() {
    topupAmount.value = 0.0;
    topUpsource.value = '';
    description.value = '';
    selectedType.value = TransactionType.topup;
  }

  Future<void> submitSendMoneyTransaction() async {
    if (!(await _shouldProceedWithBiometric())) return;
    if (sendAmount.value <= 0) {
      Get.snackbar(
        'Error',
        "Amount  required",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (receiverEmail.text == user.email) {
      Get.snackbar(
        'Error',
        "Sender Can not be reciver.please change reciver email",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    final tx = TransactionEntity(
      id: const Uuid().v4(),
      amount: sendAmount.value,
      source: '',
      type: 'send',
      description: description.value,
      date: DateTime.now(),
      currentUserEmail: user.email,
      receiverUserEmail: receiverEmail.text,
    );

    final result = await sendMoneyUsecase.repository.addTransaction(tx);
    if (result) {
      getTransactions();
      isLoading.value = false;
      Get.back();
      Get.snackbar(
        'Success',
        "${selectedType.value.name.capitalizeFirst} completed",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getTransactions() async {
    try {
      isLoading.value = true;
      final result =
          await getTransactionsUseCase.repository.getAllTransactions();
      transactions.assignAll(result);
    } catch (e) {
      throw e;
    } finally {
      isLoading.value = false;
    }
  }

  final RxList<PaymentMethod> paymentMethods = <PaymentMethod>[].obs;
  final RxString selectedPaymentMethod = ''.obs;
  final RxBool isLoadingPaymentMethods = false.obs;

  Future<void> fetchPaymentMethods() async {
    isLoadingPaymentMethods.value = true;
    try {
      paymentMethods.assignAll([
        PaymentMethod(
          id: '1',
          name: 'Visa Card',
          type: PaymentMethodType.card,
          lastFourDigits: '4242',
        ),
        PaymentMethod(
          id: '2',
          name: 'Bank Transfer',
          type: PaymentMethodType.bank,
        ),
        PaymentMethod(
          id: '3',
          name: 'Mobile Money',
          type: PaymentMethodType.mobileMoney,
        ),
      ]);
    } finally {
      isLoadingPaymentMethods.value = false;
    }
  }

  Future<bool> _shouldProceedWithBiometric() async {
    final box = Hive.box(BoxType.settings.name);
    final isBiometricEnabled = box.get(biometricKey, defaultValue: false);

    if (isBiometricEnabled) {
      final success = await localAuth.authenticateWithBiometrics();
      if (!success) {
        Get.snackbar(
          'Authentication Failed',
          'Biometric authentication is required to proceed.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return success;
    }

    return true;
  }
}
