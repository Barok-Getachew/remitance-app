import 'package:get/get.dart';
import 'package:remitance/src/modules/Transaction/data/repository/transaction_repository_impl.dart';
import 'package:remitance/src/modules/Transaction/domain/repository/transaction_repository.dart';
import 'package:remitance/src/modules/Transaction/domain/usecase/get_transactions.dart';
import 'package:remitance/src/modules/Transaction/domain/usecase/send_money_usecase.dart';
import 'package:remitance/src/modules/Transaction/domain/usecase/topup_usecase.dart';
import 'package:remitance/src/modules/Transaction/presentation/controller/home_controller.dart';

import '../../../../app/controller/hivecontroller.dart';
import '../../../../core/enum/box_types.dart';
import '../../data/datasource/local/transaction_datasource.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final hiveController = Get.find<HiveController>();
    final transactionBox = hiveController.getBox(BoxType.transactions);
    Get.lazyPut<TransactionLocalDataSource>(
        () => TransactionLocalDataSourceImpl(transactionBox: transactionBox));
    Get.lazyPut<TransactionRepository>(() => TransactionRepositoryImpl(
          Get.find<TransactionLocalDataSource>(),
        ));
    Get.lazyPut(() => TopUpUseCase(Get.find()));
    Get.lazyPut(() => SendMoneyUsecase(Get.find()));
    Get.lazyPut(() => GetTransactionsUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut(() => HomeController(
        topUpUseCase: Get.find(),
        sendMoneyUsecase: Get.find(),
        getTransactionsUseCase: Get.find()));
  }
}
