import 'package:moneymoneymoney/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel({required super.id, required super.amount});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'].toString(),
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {'id': id, 'amount': amount};
    return map;
  }
}
