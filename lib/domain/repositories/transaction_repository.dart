import 'package:moneymoneymoney/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<void> createTransaction(Transaction transaction);

  Future<List<Transaction>> getTransactions();
}
