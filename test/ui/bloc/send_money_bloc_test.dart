import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moneymoneymoney/domain/usecases/send_money_usecase.dart';
import 'package:moneymoneymoney/ui/bloc/send_money/send_money_bloc.dart';
import 'package:moneymoneymoney/ui/bloc/send_money/send_money_event.dart';
import 'package:moneymoneymoney/ui/bloc/send_money/send_money_state.dart';

import 'send_money_bloc_test.mocks.dart';

@GenerateMocks([SendMoneyUseCase])
void main() {
  late SendMoneyBloc sendMoneyBloc;
  late MockSendMoneyUseCase mockSendMoneyUseCase;

  setUp(() {
    mockSendMoneyUseCase = MockSendMoneyUseCase();
    sendMoneyBloc = SendMoneyBloc(mockSendMoneyUseCase);
  });

  const tAmount = 100.0;

  test('initial state should be SendMoneyInitial', () {
    expect(sendMoneyBloc.state, SendMoneyInitial());
  });

  blocTest<SendMoneyBloc, SendMoneyState>(
    'emits [SendMoneyLoading, SendMoneySuccess] when SendMoneyButtonPressed is added and use case succeeds.',
    build: () {
      when(mockSendMoneyUseCase.execute(any)).thenAnswer((_) async => {});
      return sendMoneyBloc;
    },
    act: (bloc) => bloc.add(SendMoneyButtonPressed(amount: tAmount)),
    expect: () => <SendMoneyState>[
      SendMoneyLoading(),
      SendMoneySuccess(),
    ],
  );
}
