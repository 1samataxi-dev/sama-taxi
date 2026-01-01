
// lib/features/profile/presentation/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sama_taxi/core/navigation/app_router.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: ListView(shrinkWrap: true,
          children: [
            // Header with time and battery
            _buildHeader(),
            const SizedBox(height: 20),
            
            // Profile Section
            _buildProfileSection(),
            const SizedBox(height: 20),
            
            // Wallet Balance Card
            _buildWalletCard(context),
            const SizedBox(height: 20),
            
            // General Section
            _buildSection('General', [
              _buildListTile(
                icon: Icons.person_outline,
                title: 'Profile Settings',
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.location_on_outlined,
                title: 'Saved Location',
                onTap: () {
                  context.pushNewLocation();
                },
              ),
              _buildListTile(
                icon: Icons.account_balance_outlined,
                title: 'Bank Details',
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.percent_outlined,
                title: 'Promo Code List',
                onTap: () {},
              ),
            ]),
            
            // App Details Section
            _buildSection('App Details', [
              // Add app details items here
                _buildListTile(
                icon: Icons.settings,
                title: 'App Settings',
                onTap: () {
                  context.pushSettings();
                },
              ),
              _buildListTile(
                icon: Icons.share,
                title: 'Share App',
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.chat,
                title: 'Chat Support',
                onTap: () {
                  context.pushChatSupport();
                },
              ),
            ]),
            
            // App Details Section
            _buildSection(isAlert: true,'Alert Zone', [
              // Add app details items here
                _buildListTile(
                  isAlert: true,
                icon: Icons.delete,
                title: 'Delete Account',
                onTap: () {},
              ),
              _buildListTile(
                isAlert: true,
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {},
              ),
             
            ]),
          ],
        ),
      ),
     // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       '18:42',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //     Row(
          //       children: [
          //         const Text('53'),
          //         const SizedBox(width: 4),
          //         SvgPicture.asset(
          //           'assets/icons/battery.svg', // Add battery icon asset
          //           width: 24,
          //           height: 24,
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          const SizedBox(height: 16),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/prpfile.avif'),
        ),
        const SizedBox(height: 12),
        const Text(
          'Jonathan Higgins',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'zaindorwart12@gmail.com',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildWalletCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFA41B), Color(0xFFFF7A00)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Wallet Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '\$156.23',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children,{bool isAlert=false}) {
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),

      child: Container(
          
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color:isAlert==true?Colors.red[200]: Colors.grey[300],
            border: Border(
              bottom: BorderSide(
                color:isAlert==true?Colors.blue: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                title,
                style: TextStyle(
                  color:(isAlert==true)?Colors.red: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(
              children: children,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool? isAlert = false,
  }) {
    return ListTile(
      subtitle: Divider(height: 1,color: Colors.black,),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:(isAlert==true)?Colors.red[100]: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color:(isAlert==true)?Colors.red[200]: Colors.blue),
      ),
      title: Text(
        title,
        style:  TextStyle(
          color:(isAlert==true)?Colors.red: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: (!isAlert!)? Icon(Icons.arrow_forward_ios, size: 16):null,
      onTap: onTap,
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined),
            label: 'My Rides',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 3, // Settings is selected
      ),
    );
  }
}

// // lib/features/settings/presentation/screens/settings_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sama_taxi/core/navigation/app_router.dart';

// class SettingsScreen extends ConsumerWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // User Profile Section
//             _buildUserProfile(),
            
//             // Wallet Balance Card
//             _buildWalletCard(context),
            
//             // General Section
//             _buildSectionTitle('General'),
//             _buildSettingsList(context),
            
//             // Registration Details Section
//             _buildSectionTitle('Registration Details'),
//             _buildRegistrationDetails(),
            
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(context, 3), // Assuming Settings is the 4th tab
//     );
//   }

//   Widget _buildUserProfile() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//            CircleAvatar(
//             radius: 40,
//             backgroundImage: AssetImage('assets/images/profile_placeholder.png'), // Add your asset
//             backgroundColor: Colors.grey[200],
//           ),
//           const SizedBox(width: 16),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'John Doe', // Replace with actual user name
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'john.doe@example.com', // Replace with actual email
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.edit, color: Colors.blue),
//             onPressed: () {
//               // Navigate to edit profile
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWalletCard(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blue.withOpacity(0.2),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.account_balance_wallet, color: Colors.white, size: 32),
//           const SizedBox(width: 16),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'My Wallet Balance',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   '\$1,234.56', // Replace with actual balance
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               context.pushNamed(AppRoutes.wallet);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.blue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//             child: const Text('View'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }

//   Widget _buildSettingsList(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Column(
//         children: [
//           _buildListTile(
//             context,
//             icon: Icons.person_outline,
//             title: 'Profile Settings',
//             onTap: () {
//               // Navigate to profile settings
//             },
//           ),
//           const Divider(height: 1),
//           _buildListTile(
//             context,
//             icon: Icons.account_balance_wallet_outlined,
//             title: 'My Wallet',
//             onTap: () {
//               context.pushNamed(AppRoutes.wallet);
//             },
//           ),
//           const Divider(height: 1),
//           _buildListTile(
//             context,
//             icon: Icons.local_offer_outlined,
//             title: 'Offer List',
//             onTap: () {
//               // Navigate to offer list
//             },
//           ),
//           const Divider(height: 1),
//           _buildListTile(
//             context,
//             icon: Icons.settings_outlined,
//             title: 'App Settings',
//             onTap: () {
//               // Navigate to app settings
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildListTile(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.blue),
//       title: Text(title),
//       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: onTap,
//     );
//   }

//   Widget _buildRegistrationDetails() {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: const Icon(Icons.description_outlined, color: Colors.blue),
//         title: const Text('Registration Details'),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: () {
//           // Navigate to registration details
//         },
//       ),
//     );
//   }

//   Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//       showSelectedLabels: true,
//       showUnselectedLabels: true,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.directions_car_outlined),
//           label: 'Active Ride',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.history),
//           label: 'My Rides',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings_outlined),
//           label: 'Settings',
//         ),
//       ],
//       onTap: (index) {
//         // Handle navigation
//         switch (index) {
//           case 0:
//             context.goNamed('home'); // Replace with your home route
//             break;
//           case 1:
//             // Navigate to active ride
//             break;
//           case 2:
//             // Navigate to my rides
//             break;
//           case 3:
//             // Already on settings
//             break;
//         }
//       },
//     );
//   }
// }
