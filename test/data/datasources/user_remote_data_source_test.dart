import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:moneymoneymoney/data/datasources/user_remote_data_source.dart';
import 'package:moneymoneymoney/data/models/user_model.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockClient mockClient;
  late UserRemoteDataSourceImpl dataSource;

  setUp(() {
    mockClient = MockClient();
    dataSource = UserRemoteDataSourceImpl(client: mockClient);
  });

  group('login', () {
    const tUsername = 'testuser';
    const tPassword = 'password';
    final tUserModel = const UserModel(
      username: tUsername,
      password: tPassword,
      remainingBalance: 1000.0,
    );

    test(
      'should return UserModel when the response code is 200 and credentials match',
      () async {
        // arrange
        when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(json.encode(tUserModel.toJson()), 200),
        );

        // act
        final result = await dataSource.login(tUsername, tPassword);

        // assert
        expect(result, equals(tUserModel));
      },
    );

    test(
      'should throw an exception when the response code is 200 but credentials do not match',
      () async {
        // arrange
        when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(json.encode(tUserModel.toJson()), 200),
        );

        // act
        final call = dataSource.login('wronguser', 'wrongpassword');

        // assert
        expect(() => call, throwsA(isA<Exception>()));
      },
    );

    test(
      'should throw an exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockClient.get(any),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.login(tUsername, tPassword);

        // assert
        expect(() => call, throwsA(isA<Exception>()));
      },
    );
  });
}
