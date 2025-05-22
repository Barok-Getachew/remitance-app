import 'package:remitance/src/modules/Transaction/domain/Entity/transaction_entity.dart';

import '../../domain/repository/transaction_repository.dart';
import '../datasource/local/transaction_datasource.dart';
import '../model/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl(this.localDataSource);

  @override
  Future<bool> addTransaction(TransactionEntity transaction) {
    // convert entity to model before passing to data source
    final model = TransactionModel.fromEntity(transaction);
    return localDataSource.addTransaction(model);
  }

  @override
  Future<List<TransactionEntity>> getAllTransactions() async {
    final models = await localDataSource.getTransactions();
    return models.map((model) => model.toEntity()).toList();
  }
}
