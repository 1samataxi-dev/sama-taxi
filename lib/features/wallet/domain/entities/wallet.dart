import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final String userId;
  final double balance;
  final String currency;
  final DateTime lastUpdated;

  Wallet({
    required this.userId,
    required this.balance,
    this.currency = 'USD', // Default currency
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  Wallet copyWith({
    String? userId,
    double? balance,
    String? currency,
    DateTime? lastUpdated,
  }) {
    return Wallet(
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object> get props => [userId, balance, currency, lastUpdated];
}
