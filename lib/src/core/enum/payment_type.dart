import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String name;
  final PaymentMethodType type; // Using enum for type safety
  final String lastFourDigits; // For cards
  final String? iconAsset; // Custom icon path
  final String? bankName; // For bank transfers
  final String? phoneNumber; // For mobile money
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    this.lastFourDigits = '',
    this.iconAsset,
    this.bankName,
    this.phoneNumber,
    this.isDefault = false,
  });

  // Helper getter for icon
  IconData get icon {
    switch (type) {
      case PaymentMethodType.card:
        return Icons.credit_card;
      case PaymentMethodType.bank:
        return Icons.account_balance;
      case PaymentMethodType.mobileMoney:
        return Icons.phone_android;
      case PaymentMethodType.crypto:
        return Icons.currency_bitcoin;
      default:
        return Icons.payment;
    }
  }

  // Display text for UI
  String get displayText {
    switch (type) {
      case PaymentMethodType.card:
        return '•••• $lastFourDigits';
      case PaymentMethodType.mobileMoney:
        return phoneNumber ?? '';
      default:
        return name;
    }
  }
}

enum PaymentMethodType { card, bank, mobileMoney, crypto, other }
