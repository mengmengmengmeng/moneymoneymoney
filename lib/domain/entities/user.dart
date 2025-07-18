import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String password;
  final double remainingBalance;

  const User({
    required this.username,
    required this.password,
    required this.remainingBalance,
  });

  @override
  List<Object?> get props => [username, password, remainingBalance];
}
