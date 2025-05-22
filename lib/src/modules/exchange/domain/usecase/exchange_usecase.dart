import '../entity/exchange_entity.dart';
import '../repos/exchage_repo.dart';

class GetExchangeRate {
  final ExchangeRepository repository;

  GetExchangeRate(this.repository);

  Future<ExchangeRate> call({
    required String fromCurrency,
    required String toCurrency,
  }) async {
    return await repository.getExchangeRate(
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
    );
  }
}

class ConvertCurrency {
  final GetExchangeRate getExchangeRate;

  ConvertCurrency(this.getExchangeRate);

  Future<double> call({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    final rate = await getExchangeRate(
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
    );
    return amount * rate.rate;
  }
}

class GetAvailableCurrencies {
  final ExchangeRepository repository;

  GetAvailableCurrencies(this.repository);

  Future<List<Currency>> call() async {
    return await repository.getAvailableCurrencies();
  }
}
