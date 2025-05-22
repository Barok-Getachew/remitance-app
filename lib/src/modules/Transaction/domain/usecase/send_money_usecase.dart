import '../Entity/transaction_entity.dart';

import '../repository/transaction_repository.dart';

class SendMoneyUsecase {
  final TransactionRepository repository;

  SendMoneyUsecase(this.repository);

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
      type: "send",
      description:
          "This amoount = $amount ETB is  Transfered to $recieverUserEmail",
      source: source,
    );

    await repository.addTransaction(transaction);
  }
}
