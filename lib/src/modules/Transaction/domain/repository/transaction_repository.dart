import '../Entity/transaction_entity.dart';

abstract class TransactionRepository {
  Future<bool> addTransaction(TransactionEntity transaction);
  Future<List<TransactionEntity>> getAllTransactions();
}
