import 'package:get/get.dart';

import '../../data/datasource/exchange_datasource.dart';
import '../../data/repository/exchange_repo_impl.dart';
import '../../domain/repos/exchage_repo.dart';
import '../../domain/usecase/exchange_usecase.dart';
import '../controller/exchange_controller.dart';

class ExchangeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetConnect());

    Get.lazyPut<ExchangeRemoteDataSource>(
      () => ExchangeRemoteDataSourceImpl(getConnect: Get.find()),
    );

    Get.lazyPut<ExchangeRepository>(
      () => ExchangeRepositoryImpl(remoteDataSource: Get.find()),
    );

    Get.lazyPut(() => GetExchangeRate(Get.find()));
    Get.lazyPut(() => ConvertCurrency(Get.find()));
    Get.lazyPut(() => GetAvailableCurrencies(Get.find()));

    Get.lazyPut(() => ExchangeController(
          convertCurrency: Get.find(),
          getAvailableCurrencies: Get.find(),
        ));
  }
}
