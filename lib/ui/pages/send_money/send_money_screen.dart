import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Column(
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
                          style: TextStyle(fontSize: 22, color: Colors.black54),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
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
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    _submitAmount();
                  },
                  child: const Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitAmount() {
    final amount = double.tryParse(_amountController.text);
    if (amount != null && amount > 0) {
      _showResultBottomSheet(true);
    } else {
      _showResultBottomSheet(false);
    }
  }

  void _showResultBottomSheet(bool isSuccess) {
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
                isSuccess
                    ? 'Your transaction was successful'
                    : 'An error occurred. Please try again.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (isSuccess) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Submit', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }
}
