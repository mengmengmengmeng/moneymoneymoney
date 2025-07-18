import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moneymoneymoney/domain/entities/transaction.dart';
import 'package:moneymoneymoney/domain/repositories/transaction_repository.dart';
import 'package:moneymoneymoney/domain/usecases/send_money_usecase.dart';

import 'send_money_usecase_test.mocks.dart';

@GenerateMocks([TransactionRepository])
void main() {
  late SendMoneyUseCase useCase;
  late MockTransactionRepository mockTransactionRepository;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    useCase = SendMoneyUseCase(mockTransactionRepository);
  });

  const tAmount = 100.0;

  test('should call createTransaction when successful', () async {
    // arrange
    when(mockTransactionRepository.createTransaction(any)).thenAnswer((_) async => {});

    // act
    await useCase.execute(tAmount);

    // assert
    final verificationResult = verify(mockTransactionRepository.createTransaction(captureAny));
    final capturedTransaction = verificationResult.captured.single as Transaction;
    expect(capturedTransaction.amount, tAmount);
  });
}
