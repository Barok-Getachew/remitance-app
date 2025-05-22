import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../../app/controller/hivecontroller.dart';
import '../../../../../core/enum/box_types.dart';
import '../../../../../core/enum/transaction_type.dart';
import '../../model/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<bool> addTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getTransactions();
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final Box transactionBox;

  TransactionLocalDataSourceImpl({required this.transactionBox});

  @override
  Future<bool> addTransaction(TransactionModel transaction) async {
    final hiveController = Get.find<HiveController>();
    final accountBox = hiveController.getBox(BoxType.account);

    await transactionBox.put(transaction.id, transaction.toMap());
    final savedTransaction = transactionBox.get(transaction.id);

    if (savedTransaction['type'] == 'topup') {
      final currentUserMap = accountBox.get(transaction.currentUserEmail);

      if (currentUserMap != null) {
        print("current$currentUserMap");
        final userMap = Map<String, dynamic>.from(currentUserMap);

        // Add amount to balance
        final currentBalance = userMap['balance'] ?? 0;
        userMap['balance'] = currentBalance + transaction.amount;

        // Save back
        await accountBox.put(transaction.currentUserEmail, userMap);
      }
    }
    if (savedTransaction['type'] == 'send') {
      final currentUserMap = accountBox.get(transaction.currentUserEmail);
      final recieverUserMap = accountBox.get(transaction.receiverUserEmail);
      print("transactio$savedTransaction");

      final userMap = Map<String, dynamic>.from(currentUserMap);
      final reciverUserMap = Map<String, dynamic>.from(recieverUserMap);

      final currentBalance = userMap['balance'] ?? 0;
      userMap['balance'] = currentBalance - transaction.amount;

      final currentReciverBalance = reciverUserMap['balance'] ?? 0;
      reciverUserMap['balance'] = currentReciverBalance + transaction.amount;

      // Save back
      await accountBox.put(transaction.currentUserEmail, userMap);
      await accountBox.put(transaction.receiverUserEmail, reciverUserMap);
    }
    return savedTransaction != null && savedTransaction['id'] == transaction.id;
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final transactions = transactionBox.values
          .map((e) => TransactionModel.fromMap(Map<String, dynamic>.from(e)))
          .toList();

      return transactions;
    } catch (e) {
      throw Exception('Failed to fetch transactions: ${e.toString()}');
    }
  }
}
