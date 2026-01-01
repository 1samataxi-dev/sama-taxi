// lib/features/wallet/presentation/screens/wallet_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/features/wallet/presentation/widgets/translations_list.dart';
import 'package:sama_taxi/features/wallet/presentation/widgets/wallet_balance_card.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Rebuild when tab changes so we can conditionally style tab containers
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('My Wallet', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Wallet Balance Card
          const WalletBalanceCard(balance: 3263.03),
          
          // Tabs
          Container(
            // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            // padding: const EdgeInsets.all(4),
            // decoration: BoxDecoration(
            //   color: Colors.grey[200],
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: TabBar(
              controller: _tabController,
              // indicator: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              //   color: Colors.black,
              // ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              tabs:  [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
              color:(_tabController.index==0)?Colors.blue: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
                  child: Tab(text: 'Total Earning')),
                
                  
                   Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
              color:(_tabController.index==1)?Colors.blue: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
                  child: Tab(text: 'Withdraw History')),
              ],
            ),
          ),
          
          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                TransactionScreen(),
                Center(child: Text('Withdraw History')),
              ],
            ),
          ),
          
          // Withdraw Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
                child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement withdraw functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Withdraw',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}