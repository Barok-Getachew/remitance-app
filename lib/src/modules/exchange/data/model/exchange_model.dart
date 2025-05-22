// lib/data/models/exchange_rate_dto.dart
import '../../domain/entity/exchange_entity.dart';

class ExchangeRateModel {
  final String base;
  final Map<String, double> rates;
  final DateTime date;

  ExchangeRateModel({
    required this.base,
    required this.rates,
    required this.date,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
    return ExchangeRateModel(
      base: json['base'],
      rates: Map<String, double>.from(json['rates']),
      date: DateTime.parse(json['date']),
    );
  }

  ExchangeRate toEntity(String toCurrency) {
    return ExchangeRate(
      fromCurrency: base,
      toCurrency: toCurrency,
      rate: rates[toCurrency] ?? 1.0,
      lastUpdated: date,
    );
  }
}
