import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moneymoneymoney/data/datasources/transaction_remote_data_source.dart';
import 'package:moneymoneymoney/data/models/transaction_model.dart';

import 'transaction_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late TransactionRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = TransactionRemoteDataSourceImpl(client: mockHttpClient);
  });

  final tTransactionModel = TransactionModel(
    id: '1',
    amount: 100.0,
  );

  final tUri = Uri.parse('https://my-json-server.typicode.com/mengmengmengmeng/monay/transactions');

  test('should perform a POST request on a URL with transaction body', () async {
    // arrange
    when(mockHttpClient.post(tUri, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('', 201));

    // act
    await dataSource.createTransaction(tTransactionModel);

    // assert
    verify(mockHttpClient.post(
      tUri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(tTransactionModel.toJson()),
    ));
  });

  test('should throw a ServerException when the response code is not 201', () async {
    // arrange
    when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('Something went wrong', 500));

    // act
    final call = dataSource.createTransaction;

    // assert
    expect(() => call(tTransactionModel), throwsA(isA<Exception>()));
  });
}
