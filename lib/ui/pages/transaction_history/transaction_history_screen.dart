import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneymoneymoney/injection.dart';
import 'package:moneymoneymoney/ui/bloc/transaction_history/transaction_history_bloc.dart';
import 'package:moneymoneymoney/ui/bloc/transaction_history/transaction_history_event.dart';
import 'package:moneymoneymoney/ui/bloc/transaction_history/transaction_history_state.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<TransactionHistoryBloc>()..add(LoadTransactions()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Transaction History')),
        body: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
          builder: (context, state) {
            if (state is TransactionHistoryLoading ||
                state is TransactionHistoryInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionHistoryLoaded) {
              if (state.transactions.isEmpty) {
                return const Center(child: Text('No transactions yet.'));
              }
              return ListView.builder(
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = state.transactions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: ListTile(
                      title: Text(
                        '- ₱ ${transaction.amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is TransactionHistoryError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Something went wrong.'));
          },
        ),
      ),
    );
  }
}
