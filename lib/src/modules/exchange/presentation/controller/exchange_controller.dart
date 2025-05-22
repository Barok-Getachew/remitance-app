import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entity/exchange_entity.dart';
import '../../domain/usecase/exchange_usecase.dart';

class ExchangeController extends GetxController {
  final ConvertCurrency convertCurrency;
  final GetAvailableCurrencies getAvailableCurrencies;

  ExchangeController({
    required this.convertCurrency,
    required this.getAvailableCurrencies,
  });

  final amount = ''.obs;
  final fromCurrency = 'USD'.obs;
  final toCurrency = 'EUR'.obs;
  final convertedAmount = ''.obs;
  final availableCurrencies = <Currency>[].obs;
  final isLoading = false.obs;
  final error = RxString('');
  bool _isSnackbarActive = false;

  @override
  void onInit() {
    super.onInit();
    ever(fromCurrency, (_) => convert()); // React to currency changes
    ever(toCurrency, (_) => convert());
    loadAvailableCurrencies();
  }

  Future<void> loadAvailableCurrencies() async {
    isLoading(true);
    try {
      final currencies = await getAvailableCurrencies();
      availableCurrencies.assignAll(currencies);

      if (!availableCurrencies.any((c) => c.code == fromCurrency.value)) {
        fromCurrency.value = 'USD';
      }
      if (!availableCurrencies.any((c) => c.code == toCurrency.value)) {
        toCurrency.value = 'EUR';
      }
    } catch (e) {
      error.value = 'Failed to load currencies';
    } finally {
      isLoading(false);
    }
  }

  Future<void> convert() async {
    isLoading(true);
    try {
      final parsedAmount = double.tryParse(amount.value) ?? 0;
      final result = await convertCurrency(
        amount: parsedAmount,
        fromCurrency: fromCurrency.value,
        toCurrency: toCurrency.value,
      );
      convertedAmount.value = result.toStringAsFixed(2);
      error.value = '';
    } catch (e) {
      final errorMessage = e.toString().contains('SocketException')
          ? 'Please check your connection'
          : e.toString();

      if (!_isSnackbarActive) {
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      _isSnackbarActive = true;
    } finally {
      isLoading(false);
    }
  }

  void updateAmount(String value) {
    amount.value = value;
    if (value.isNotEmpty) {
      convert();
    } else {
      convertedAmount.value = '';
    }
  }

  void updateFromCurrency(String currency) {
    fromCurrency.value = currency;
    if (amount.value.isNotEmpty) {
      convert();
    }
  }

  void updateToCurrency(String currency) {
    toCurrency.value = currency;
    if (amount.value.isNotEmpty) {
      convert();
    }
  }

  void swapCurrencies() {
    final temp = fromCurrency.value;
    fromCurrency.value = toCurrency.value;
    toCurrency.value = temp;
    if (amount.value.isNotEmpty) {
      convert();
    }
  }
}
