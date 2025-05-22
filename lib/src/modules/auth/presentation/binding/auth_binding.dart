// lib/presentation/bindings/auth_binding.dart
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../app/controller/hivecontroller.dart';
import '../../../../core/enum/box_types.dart';
import '../../data/datasource/local/user_local_data_source.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/user_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/signup_usecase.dart';
import '../controller/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    final hiveController = Get.find<HiveController>();
    final accountBox = hiveController.getBox(BoxType.account);

    Get.lazyPut<UserLocalDataSource>(
        () => UserLocalDataSourceImpl(userBox: accountBox));

    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(
          localDataSource: Get.find<UserLocalDataSource>(),
        ));

    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => RegisterUseCase(Get.find()));

    Get.lazyPut(() => AuthController(
          loginUseCase: Get.find(),
          registerUseCase: Get.find(),
        ));
  }
}
