import 'package:equatable/equatable.dart';

abstract class SendMoneyState extends Equatable {
  const SendMoneyState();

  @override
  List<Object> get props => [];
}

class SendMoneyInitial extends SendMoneyState {}

class SendMoneyLoading extends SendMoneyState {}

class SendMoneySuccess extends SendMoneyState {}

class SendMoneyFailure extends SendMoneyState {
  final String error;

  const SendMoneyFailure({required this.error});

  @override
  List<Object> get props => [error];
}
