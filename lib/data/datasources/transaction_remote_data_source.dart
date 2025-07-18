import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/data/models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<void> createTransaction(TransactionModel transaction);

  Future<List<TransactionModel>> getTransactions();
}

@Injectable(as: TransactionRemoteDataSource)
class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final http.Client client;

  TransactionRemoteDataSourceImpl({required this.client});

  final String _baseUrl =
      'https://my-json-server.typicode.com/mengmengmengmeng/monay/transactions';

  @override
  Future<void> createTransaction(TransactionModel transaction) async {
    // Yep, this is a mock API, not a real one.
    // The successful POST request will be persisted. So, no POST/UPDATES are
    // made to the API db.json
    final response = await client.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(transaction.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create transaction.');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    // Yep, this is a mock API, not a real one.
    // Displaying the transactions from the db.json
    final response = await client.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}
