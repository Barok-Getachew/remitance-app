// lib/data/datasources/exchange_remote_data_source.dart
import 'dart:io';

import 'package:get/get.dart';
import 'package:remitance/src/modules/exchange/data/model/exchange_model.dart';

abstract class ExchangeRemoteDataSource {
  Future<ExchangeRateModel> getLatestRates(String from, String to);
}

class ExchangeRemoteDataSourceImpl implements ExchangeRemoteDataSource {
  final GetConnect getConnect;

  ExchangeRemoteDataSourceImpl({required this.getConnect});

  @override
  Future<ExchangeRateModel> getLatestRates(String from, String to) async {
    try {
      final response = await getConnect.get(
        "https://api.frankfurter.dev/v1/latest?base=$from&symbols=$to",
      );

      if (response.hasError) {
        throw Exception('Failed to fetch rates: ${response.statusText}');
      }

      return ExchangeRateModel.fromJson(response.body);
    } on SocketException {
      throw SocketException(
          'No Internet connection. Please check your network.');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
