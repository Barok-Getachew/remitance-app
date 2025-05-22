// lib/domain/repositories/exchange_repository.dart
import '../entity/exchange_entity.dart';

abstract class ExchangeRepository {
  Future<ExchangeRate> getExchangeRate({
    required String fromCurrency,
    required String toCurrency,
  });

  Future<List<Currency>> getAvailableCurrencies();
}
