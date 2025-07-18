import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login(String username, String password);
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String username, String password) async {
    // Yep, this is a mock API, not a real one. GET /user and then compare from
    // mobile login credentials :D
    final response = await client.get(
      Uri.parse(
        'https://my-json-server.typicode.com/mengmengmengmeng/monay/user',
      ),
    );

    if (response.statusCode == 200) {
      final user = UserModel.fromJson(json.decode(response.body));
      if (user.username == username && user.password == password) {
        return user;
      } else {
        throw Exception('Invalid credentials');
      }
    } else {
      throw Exception('Failed to load user');
    }
  }
}
