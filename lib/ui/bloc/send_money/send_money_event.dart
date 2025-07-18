import 'package:equatable/equatable.dart';

abstract class SendMoneyEvent extends Equatable {
  const SendMoneyEvent();

  @override
  List<Object> get props => [];
}

class SendMoneyButtonPressed extends SendMoneyEvent {
  final double amount;

  const SendMoneyButtonPressed({required this.amount});

  @override
  List<Object> get props => [amount];
}
