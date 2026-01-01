import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/widgets/appbar.dart';
import 'package:sama_taxi/features/lists/presentation/categories_screen.dart';
import 'package:sama_taxi/features/offers/presentation/screens/offers_screen.dart';
import '../widgets/ready_card.dart';


class SamaHomeScreen extends StatelessWidget {
  const SamaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: AppStrings.taxify.tr(),
        bottom: _buildSearchBar(),
        showSearch: true,
         actions: [
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
          onPressed: () {},
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],),
     
  body: CustomScrollView(
  slivers: [
    // Header section
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            // Horizontal scrollable section
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  ReadyCard(),
                  SizedBox(width: 16),
                  ReadyCard(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(AppStrings.topCategories.tr()),
            const SizedBox(height: 16),
            const TopCategories(),
            const SizedBox(height: 24),
            _buildSectionTitle(AppStrings.todaysOffers.tr()),
          ],
        ),
      ),
    ),
    // Offers list - Use SliverList instead of SliverFillRemaining
    SliverList(
      delegate: SliverChildListDelegate([
        OffersScreen(),
      ]),
    ),
  ],
),

    );
  }
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child:  Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchDestinations.tr(),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Icon(Icons.calendar_today, color: Colors.grey),
        ],
      ),
    );
  }

PreferredSizeWidget _buildAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(120),
    child: AppBar(
      
         
      
      title: const Text(
        'Taxify',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
          onPressed: () {},
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.account_balance_wallet_outlined, color: Colors.black),
          onPressed: () {},
        ),
      ],

      // ✅ SEARCH BAR IN BOTTOM SECTION
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(30),
            child: TextField(
              decoration: InputDecoration(
                hintText: '${AppStrings.searchDestinations.tr()}...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.calendar_today),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

  // PreferredSizeWidget _buildAppBar() {
  //   return AppBar(


  // Widget _buildCategories() {
  //   return const Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       CategoryCard(
  //         icon: Icons.directions_car,
  //         label: 'Ride',
  //       ),
  //       CategoryCard(
  //         icon: Icons.airport_shuttle,
  //         label: 'Outstation',
  //       ),
  //       CategoryCard(
  //         icon: Icons.car_rental,
  //         label: 'Rental',
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildBottomNavigationBar() {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: Colors.black,
  //     unselectedItemColor: Colors.grey,
  //     showUnselectedLabels: true,
  //     items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home_filled),
  //         label: 'Home',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.apps_rounded),
  //         label: 'Category',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.directions_car),
  //         label: 'My Rides',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.settings),
  //         label: 'Settings',
  //       ),
  //     ],
  //   );
 // }
}
