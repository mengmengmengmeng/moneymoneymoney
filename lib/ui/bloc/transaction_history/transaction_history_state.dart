import 'package:equatable/equatable.dart';
import 'package:moneymoneymoney/domain/entities/transaction.dart';

abstract class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();

  @override
  List<Object> get props => [];
}

class TransactionHistoryInitial extends TransactionHistoryState {}

class TransactionHistoryLoading extends TransactionHistoryState {}

class TransactionHistoryLoaded extends TransactionHistoryState {
  final List<Transaction> transactions;

  const TransactionHistoryLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionHistoryError extends TransactionHistoryState {
  final String message;

  const TransactionHistoryError(this.message);

  @override
  List<Object> get props => [message];
}
