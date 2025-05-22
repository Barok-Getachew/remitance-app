// lib/data/repositories/exchange_repository_impl.dart
import '../../domain/entity/exchange_entity.dart';
import '../../domain/repos/exchage_repo.dart';
import '../datasource/exchange_datasource.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSource remoteDataSource;

  ExchangeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ExchangeRate> getExchangeRate({
    required String fromCurrency,
    required String toCurrency,
  }) async {
    try {
      final dto =
          await remoteDataSource.getLatestRates(fromCurrency, toCurrency);
      return dto.toEntity(toCurrency);
    } catch (e) {
      throw Exception('Failed to get exchange rate: $e');
    }
  }

  @override
  Future<List<Currency>> getAvailableCurrencies() async {
    return Currency.values;
  }
}
