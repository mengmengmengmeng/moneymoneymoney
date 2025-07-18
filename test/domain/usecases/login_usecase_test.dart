import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moneymoneymoney/domain/entities/user.dart';
import 'package:moneymoneymoney/domain/usecases/login_usecase.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late LoginUseCase usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = LoginUseCase(mockUserRepository);
  });

  const tUsername = 'testuser';
  const tPassword = 'password';
  final tUser = const User(
    username: tUsername,
    password: tPassword,
    remainingBalance: 1000.0,
  );

  test('should get user from the repository', () async {
    // arrange
    when(
      mockUserRepository.login(tUsername, tPassword),
    ).thenAnswer((_) async => tUser);

    // act
    final result = await usecase.execute(tUsername, tPassword);

    // assert
    expect(result, tUser);
    verify(mockUserRepository.login(tUsername, tPassword));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
