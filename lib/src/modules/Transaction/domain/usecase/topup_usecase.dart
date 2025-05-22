import '../Entity/transaction_entity.dart';

import '../repository/transaction_repository.dart';

class TopUpUseCase {
  final TransactionRepository repository;

  TopUpUseCase(this.repository);

  Future<void> execute({
    required double amount,
    required String source,
    required String currentUserEmail,
    required String recieverUserEmail,
  }) async {
    final transaction = TransactionEntity(
      receiverUserEmail: recieverUserEmail,
      currentUserEmail: currentUserEmail,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      date: DateTime.now(),
      type: "topup",
      description: "Top-up of $amount ETB from $source",
      source: source,
    );

    await repository.addTransaction(transaction);
  }
}
