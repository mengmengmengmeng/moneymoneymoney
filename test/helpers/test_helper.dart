import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:moneymoneymoney/data/datasources/user_remote_data_source.dart';
import 'package:moneymoneymoney/domain/repositories/user_repository.dart';
import 'package:moneymoneymoney/domain/usecases/login_usecase.dart';

@GenerateMocks([
  UserRepository,
  UserRemoteDataSource,
  LoginUseCase,
  http.Client,
])
void main() {}
