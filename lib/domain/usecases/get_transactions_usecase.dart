import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/domain/entities/transaction.dart';
import 'package:moneymoneymoney/domain/repositories/transaction_repository.dart';

@injectable
class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<List<Transaction>> execute() {
    return repository.getTransactions();
  }
}
