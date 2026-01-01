// lib/features/wallet/presentation/providers/wallet_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/features/wallet/domain/entities/wallet_transaction.dart';

final walletBalanceProvider = StateProvider<double>((ref) {
  return 3263.03; // Initial balance
});

final transactionsProvider = FutureProvider<List<WalletTransaction>>((ref) async {
  // In a real app, this would fetch from an API
  return [
    const WalletTransaction(
      id: '1',
      title: 'Admin Commission Debit',
      description: 'Commission for ride #RIDE123',
      amount: 15.50,
      type: TransactionType.debit,
      date: '2023-05-15',
    ),
    const WalletTransaction(
      id: '2',
      title: 'Wallet Top Up',
      description: 'Added funds via credit card',
      amount: 100.00,
      type: TransactionType.credit,
      date: '2023-05-10',
    ),
    // Add more sample transactions as needed
  ];
});