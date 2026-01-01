// lib/features/wallet/presentation/widgets/transaction_list.dart
import 'package:flutter/material.dart';
import 'package:sama_taxi/features/wallet/domain/entities/wallet_transaction.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/widgets/empty_widget.dart';
import 'package:sama_taxi/core/widgets/error_widget.dart';
import 'package:sama_taxi/core/widgets/loading_widget.dart';
import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionState = ref.watch(localTransactionsViewModelProvider);

    return _TransactionStateHandler(
      state: transactionState,
      onRetry: _handleRetry,
      onRefresh: _handleRefresh,
    );
  }

  void _handleRetry() {
    ref.read(localTransactionsViewModelProvider.notifier).loadItems();
  }

  Future<void> _handleRefresh() async {
    await ref.read(localTransactionsViewModelProvider.notifier).loadItems();
  }
}

class _TransactionStateHandler extends StatelessWidget {
  const _TransactionStateHandler({
    required this.state,
    required this.onRetry,
    required this.onRefresh,
  });

  final dynamic state;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const LoadingWidget();
    }

    if (state.error != null) {
      return ErrorDisplayWidget(message: state.error, onRetry: onRetry);
    }

    if (state.items.isEmpty) {
      return EmptyWidget(message: AppStrings.noData.tr(), icon: Icons.cabin);
    }

    return _TransactionList(Transaction: state.items, onRefresh: onRefresh);
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList({required this.Transaction, required this.onRefresh});

  final List<WalletTransaction> Transaction;
  final Future<void> Function() onRefresh;

  static const EdgeInsets _listPadding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) => 
  
  LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: Transaction.isEmpty
              ? const Center(child: Text('No Transaction available'))
              :  ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: Transaction.length,
      itemBuilder: (context, index) {
        final transaction = Transaction[index];
        return TransactionItem(transaction: transaction);
      },
    )
        );
      },
    );
}

// class TransactionCard extends StatelessWidget {
//   const TransactionCard({super.key, required this.offer});

//   final Transaction offer;

//   static const EdgeInsets _cardMargin = EdgeInsets.only(bottom: 10);
//   static const EdgeInsets _cardPadding = EdgeInsets.all(16);
//   static const BorderRadius _cardBorderRadius = BorderRadius.all(
//     Radius.circular(12),
//   );

//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.symmetric(horizontal:15.0),
//     child: Card(
//         margin: _cardMargin,
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: _cardBorderRadius,
//         ),
//         child: InkWell(
//           onTap: () => _navigateToDetails(context),
//           borderRadius: _cardBorderRadius,
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               borderRadius: _cardBorderRadius,
//               color: Colors.white,
//               border: Border.all(color: Colors.grey[200]!),
//             ),
//             height: 150,
//             child: Row(
//               children: [
//                 // Discount Tag
//                 Container(
//                   width: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       bottomLeft: Radius.circular(12),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${offer.discount.toInt()}%\noff',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         height: 1.2,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 // Offer Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Driver Info
//                       Row(
//                         children: [
//                           Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               shape: BoxShape.circle,
                              
//                             ),
//                             child: Icon(Icons.person),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   offer.driverName.isNotEmpty 
//                                       ? offer.driverName 
//                                       : 'No driver name',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                     Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Icon(Icons.star, color: Colors.amber, size: 16),
//                                     const SizedBox(width: 4),
//                                     Text(
//                                       offer.rating.toStringAsFixed(1),
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
                            
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                         Text(
//                         '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 12,
//                         ),
//                       ),
//                      const SizedBox(height: 5),
//                       // Offer Details
//                       Text(
//                         'Up to 10 km from Wankover city area',
//                          style: TextStyle(
                         
//                           fontSize: 12,
//                           fontWeight:   FontWeight.bold,
                        
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(Icons.car_rental_outlined),
//                            const SizedBox(width: 4),
//                           Text(
//                             '${offer.carType} | ',
//                             style: TextStyle(
//                              fontSize: 12,
//                           fontWeight:   FontWeight.bold,
//                             ),
//                           ), 
                          
//                           Text(
//                             offer.capacity,
//                             style: TextStyle(
//                              fontSize: 12,
//                           fontWeight:   FontWeight.bold,
//                             ),
//                           ),
    
    
                         
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Valid Till:',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 12,
//                             ),
//                           ),
//                           Text( offer.validUntil, style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 12,
//                             ),)
//                         ],
//                       ),
                      
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//   );

//   void _navigateToDetails(BuildContext context) {
//     // Navigator.of(context).push(
//     //   MaterialPageRoute(builder: (context) => TransactionDetailsScreen(offer: offer)),
//     // );
//   }
// }




class TransactionItem extends StatelessWidget {
  final WalletTransaction transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.type == TransactionType.credit;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.receipt_long,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    transaction.description,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isCredit ? '\u2193' : '\u2191'} \$${transaction.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: isCredit ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

