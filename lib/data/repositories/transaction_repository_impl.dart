import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/data/datasources/transaction_remote_data_source.dart';
import 'package:moneymoneymoney/data/models/transaction_model.dart';
import 'package:moneymoneymoney/domain/entities/transaction.dart';
import 'package:moneymoneymoney/domain/repositories/transaction_repository.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createTransaction(Transaction transaction) async {
    final transactionModel = TransactionModel(
      id: transaction.id,
      amount: transaction.amount,
    );
    await remoteDataSource.createTransaction(transactionModel);
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    return await remoteDataSource.getTransactions();
  }
}
