import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/domain/usecases/get_transactions_usecase.dart';
import 'package:moneymoneymoney/ui/bloc/transaction_history/transaction_history_event.dart';
import 'package:moneymoneymoney/ui/bloc/transaction_history/transaction_history_state.dart';

@injectable
class TransactionHistoryBloc
    extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  final GetTransactionsUseCase getTransactionsUseCase;

  TransactionHistoryBloc(this.getTransactionsUseCase)
    : super(TransactionHistoryInitial()) {
    on<LoadTransactions>((event, emit) async {
      emit(TransactionHistoryLoading());
      try {
        final transactions = await getTransactionsUseCase.execute();
        emit(TransactionHistoryLoaded(transactions));
      } catch (e) {
        emit(TransactionHistoryError(e.toString()));
      }
    });
  }
}
