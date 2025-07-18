import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/domain/entities/user.dart';
import 'package:moneymoneymoney/domain/repositories/user_repository.dart';

@injectable
class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String username, String password) {
    return repository.login(username, password);
  }
}
