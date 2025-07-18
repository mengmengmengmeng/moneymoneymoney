import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  // Dummy data for transaction history
  final List<Map<String, dynamic>> transactions = const [
    {'amount': '50.00', 'date': '18 Jul, 2025'},
    {'amount': '200.00', 'date': '16 Jul, 2025'},
    {'amount': '15.50', 'date': '13 Jul, 2025'},
    {'amount': '100.00', 'date': '10 Jul, 2025'},
    {'amount': '500.00', 'date': '8 Jul, 2025'},
    {'amount': '75.00', 'date': '6 Jul, 2025'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text('${transaction['date']}'),
              trailing: Text('- ₱ ${transaction['amount']}'),
            ),
          );
        },
      ),
    );
  }
}
