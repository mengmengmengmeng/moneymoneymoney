import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moneymoneymoney/data/datasources/transaction_remote_data_source.dart';
import 'package:moneymoneymoney/data/models/transaction_model.dart';
import 'package:moneymoneymoney/data/repositories/transaction_repository_impl.dart';
import 'package:moneymoneymoney/domain/entities/transaction.dart';

import 'transaction_repository_impl_test.mocks.dart';

@GenerateMocks([TransactionRemoteDataSource])
void main() {
  late TransactionRepositoryImpl repository;
  late MockTransactionRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTransactionRemoteDataSource();
    repository = TransactionRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  final tTransaction = Transaction(id: '1', amount: 100.0);
  final tTransactionModel = TransactionModel(
    id: tTransaction.id,
    amount: tTransaction.amount,
  );

  test('should call createTransaction on the remote data source', () async {
    // arrange
    when(mockRemoteDataSource.createTransaction(any)).thenAnswer((_) async => {});

    // act
    await repository.createTransaction(tTransaction);

    // assert
    verify(mockRemoteDataSource.createTransaction(tTransactionModel));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
