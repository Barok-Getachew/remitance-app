class TransactionEntity {
  final String id;
  final double amount;
  final String currentUserEmail;
  final String? receiverUserEmail;
  final DateTime date;
  final String type;
  final String description;
  final String source;

  TransactionEntity({
    required this.currentUserEmail,
    required this.receiverUserEmail,
    required this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.description,
    required this.source,
  });
}
