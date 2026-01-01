import 'package:equatable/equatable.dart';

enum TransactionType { credit, debit }

class WalletTransaction extends Equatable {
  final String id;
  final String title;
  final String description;
  final double amount;
  final TransactionType type;
  final String date;
  final String? referenceId;

  const WalletTransaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
    this.referenceId,
  });
  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] == 'credit' ? TransactionType.credit : TransactionType.debit,
      date: json['date'] as String,
      referenceId: json['reference_id'] as String?,
    );
  }


  @override
  List<Object?> get props => [id, title, amount, type, date];

  bool get isCredit => type == TransactionType.credit;
}

 List<WalletTransaction> localTransaction=[
  WalletTransaction(
    id: '1',
    title: 'Ride Payment',
    description: 'Payment for ride to airport',
    amount: 25.00,
    type: TransactionType.debit,
    date: '2024-06-01',
    referenceId: 'RIDE12345',
  ),
  WalletTransaction(
    id: '2',
    title: 'Wallet Top-Up',
    description: 'Added funds to wallet',
    amount: 50.00,
    type: TransactionType.credit,
    date: '2024-06-02',
  ),
  WalletTransaction(
    id: '3',
    title: 'Ride Payment',
    description: 'Payment for ride to downtown',
    amount: 15.75,
    type: TransactionType.debit,
    date: '2024-06-03',
    referenceId: 'RIDE12346',
  ),
  WalletTransaction(
    id: '4',
    title: 'Promotional Credit',
    description: 'Credit from promo code',  
    amount: 10.00,
    type: TransactionType.credit,
    date: '2024-06-04',
  ),
  WalletTransaction(
    id: '5',
    title: 'Ride Payment',
    description: 'Payment for ride to office',
    amount: 18.50,
    type: TransactionType.debit,
    date: '2024-06-05',
    referenceId: 'RIDE12347',
  ), 
  
 ];