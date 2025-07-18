import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moneymoneymoney/domain/entities/transaction.dart';
import 'package:moneymoneymoney/domain/usecases/get_transactions_usecase.dart';
import 'package:moneymoneymoney/ui/bloc/transaction_history/transaction_history_bloc.dart';
import 'package:moneymoneymoney/ui/bloc/transaction_history/transaction_history_event.dart';
import 'package:moneymoneymoney/ui/bloc/transaction_history/transaction_history_state.dart';

import 'transaction_history_bloc_test.mocks.dart';

@GenerateMocks([GetTransactionsUseCase])
void main() {
  late TransactionHistoryBloc transactionHistoryBloc;
  late MockGetTransactionsUseCase mockGetTransactionsUseCase;

  setUp(() {
    mockGetTransactionsUseCase = MockGetTransactionsUseCase();
    transactionHistoryBloc = TransactionHistoryBloc(mockGetTransactionsUseCase);
  });

  tearDown(() {
    transactionHistoryBloc.close();
  });

  group('TransactionHistoryBloc', () {
    final tTransactions = [Transaction(id: '1', amount: 100)];

    test('initial state is TransactionHistoryInitial', () {
      expect(transactionHistoryBloc.state, TransactionHistoryInitial());
    });

    blocTest<TransactionHistoryBloc, TransactionHistoryState>(
      'emits [TransactionHistoryLoading, TransactionHistoryLoaded] when LoadTransactions is added.',
      build: () {
        when(mockGetTransactionsUseCase.execute()).thenAnswer((_) async => tTransactions);
        return transactionHistoryBloc;
      },
      act: (bloc) => bloc.add(LoadTransactions()),
      expect: () => [
        TransactionHistoryLoading(),
        TransactionHistoryLoaded(tTransactions),
      ],
    );

    blocTest<TransactionHistoryBloc, TransactionHistoryState>(
      'emits [TransactionHistoryLoading, TransactionHistoryError] when getTransactionsUseCase throws an error.',
      build: () {
        when(mockGetTransactionsUseCase.execute()).thenThrow(Exception('Failed to load transactions'));
        return transactionHistoryBloc;
      },
      act: (bloc) => bloc.add(LoadTransactions()),
      expect: () => [
        TransactionHistoryLoading(),
        isA<TransactionHistoryError>(),
      ],
    );
  });
}
