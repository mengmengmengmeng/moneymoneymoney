import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moneymoneymoney/domain/entities/user.dart';
import 'package:moneymoneymoney/ui/bloc/login/login_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginBloc loginBloc;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginBloc = LoginBloc(mockLoginUseCase);
  });

  const tUsername = 'testuser';
  const tPassword = 'password';
  final tUser = const User(
    username: tUsername,
    password: tPassword,
    remainingBalance: 1000.0,
  );

  test('initial state should be LoginInitial', () {
    expect(loginBloc.state, equals(LoginInitial()));
  });

  blocTest<LoginBloc, LoginState>(
    'should emit [LoginLoading, LoginSuccess] when login is successful',
    build: () {
      when(
        mockLoginUseCase.execute(tUsername, tPassword),
      ).thenAnswer((_) async => tUser);
      return loginBloc;
    },
    act: (bloc) => bloc.add(
      const LoginButtonPressed(username: tUsername, password: tPassword),
    ),
    expect: () => <LoginState>[LoginLoading(), LoginSuccess(user: tUser)],
  );

  blocTest<LoginBloc, LoginState>(
    'should emit [LoginLoading, LoginFailure] when login is unsuccessful',
    build: () {
      when(
        mockLoginUseCase.execute(tUsername, tPassword),
      ).thenThrow(Exception('Login failed'));
      return loginBloc;
    },
    act: (bloc) => bloc.add(
      const LoginButtonPressed(username: tUsername, password: tPassword),
    ),
    expect: () => <LoginState>[
      LoginLoading(),
      const LoginFailure(error: 'Exception: Login failed'),
    ],
  );
}
