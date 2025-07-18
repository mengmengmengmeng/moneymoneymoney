import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneymoneymoney/domain/entities/user.dart';
import 'package:moneymoneymoney/injection.dart';
import 'package:moneymoneymoney/ui/bloc/send_money/send_money_bloc.dart';
import 'package:moneymoneymoney/ui/bloc/send_money/send_money_event.dart';
import 'package:moneymoneymoney/ui/bloc/send_money/send_money_state.dart';

class SendMoneyScreen extends StatelessWidget {
  final User user;

  const SendMoneyScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController();

    return BlocProvider(
      create: (context) => getIt<SendMoneyBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Send Money')),
        body: BlocListener<SendMoneyBloc, SendMoneyState>(
          listener: (context, state) {
            if (state is SendMoneySuccess) {
              _showInfoBottomSheet(
                context,
                title: 'Your transaction was successful',
                buttonText: 'Submit',
                onButtonPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              );
            } else if (state is SendMoneyFailure) {
              _showInfoBottomSheet(
                context,
                title: 'An error occurred. Please try again.',
                buttonText: 'Close',
                onButtonPressed: () {
                  Navigator.of(context).pop();
                },
              );
            }
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 30.0,
                          horizontal: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Amount',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                prefixText: '₱ ',
                                hintText: '0.00',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<SendMoneyBloc, SendMoneyState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: state is SendMoneyLoading
                              ? null
                              : () {
                                  final amount = double.tryParse(
                                    amountController.text,
                                  );
                                  if (amount == null || amount <= 0) {
                                    _showInfoBottomSheet(
                                      context,
                                      title: 'Invalid Amount',
                                      message: 'Please enter a valid amount.',
                                      buttonText: 'OK',
                                      onButtonPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  } else {
                                    context.read<SendMoneyBloc>().add(
                                      SendMoneyButtonPressed(amount: amount),
                                    );
                                  }
                                },
                          child: state is SendMoneyLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 18),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInfoBottomSheet(
    BuildContext context, {
    required String title,
    String? message,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 30,
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: 8.0),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 16.0),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: onButtonPressed,
                child: Text(buttonText, style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }
}
