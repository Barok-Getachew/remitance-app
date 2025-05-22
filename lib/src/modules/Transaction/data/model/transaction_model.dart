import '../../domain/Entity/transaction_entity.dart';

class TransactionModel {
  final String id;
  final double amount;
  final DateTime date;
  final String type; // topup, send, receive
  final String description;
  final String source;
  final String currentUserEmail;
  final String? receiverUserEmail;

  TransactionModel({
    required this.currentUserEmail,
    required this.receiverUserEmail,
    required this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.description,
    required this.source,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type,
      'description': description,
      'source': source,
      'currentUserEmail': currentUserEmail,
      'recieverUserEmail': receiverUserEmail,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] ?? '', // default empty string if null
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      date: map['date'] != null
          ? DateTime.parse(map['date'])
          : DateTime.now(), // or handle null date as needed
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      source: map['source'] ?? '',
      currentUserEmail: map['currentUserEmail'] ?? '',
      receiverUserEmail: map['recieverUserEmail'] ?? '',
    );
  }
  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      amount: entity.amount,
      source: entity.source,
      receiverUserEmail: entity.receiverUserEmail,
      currentUserEmail: entity.currentUserEmail,
      type: entity.type,
      description: entity.description,
      date: entity.date,
    );
  }
}

extension TransactionModelMapper on TransactionModel {
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      amount: amount,
      source: source,
      receiverUserEmail: receiverUserEmail,
      currentUserEmail: currentUserEmail,
      type: type,
      description: description,
      date: date,
    );
  }
}
