import 'package:remitance/src/modules/Transaction/domain/Entity/transaction_entity.dart';

import '../repository/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase({required this.repository});

  @override
  Future<List<TransactionEntity>> execute({String? userId}) async {
    try {
      // Get all transactions
      final transactions = await repository.getAllTransactions();

      // Filter by user if userId is provided
      if (userId != null) {
        return transactions
            .where((t) =>
                t.currentUserEmail == userId || t.receiverUserEmail == userId)
            .toList();
      }

      return transactions;
    } catch (e) {
      throw e;
    }
  }
}
