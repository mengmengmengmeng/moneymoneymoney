import 'package:moneymoneymoney/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.username,
    required super.password,
    required super.remainingBalance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      password: json['password'],
      remainingBalance: (json['remaining_balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'remaining_balance': remainingBalance,
    };
  }
}
