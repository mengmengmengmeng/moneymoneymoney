import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/domain/entities/transaction.dart';
import 'package:moneymoneymoney/domain/repositories/transaction_repository.dart';

@injectable
class SendMoneyUseCase {
  final TransactionRepository transactionRepository;

  SendMoneyUseCase(this.transactionRepository);

  Future<void> execute(double amount) async {
    final random = Random();
    final id = List<int>.generate(
      16,
      (_) => random.nextInt(256),
    ).map((i) => i.toRadixString(16).padLeft(2, '0')).join();

    final transaction = Transaction(id: id, amount: amount);
    await transactionRepository.createTransaction(transaction);
  }
}
