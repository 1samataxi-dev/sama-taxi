import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sama_taxi/features/auth/presentation/screens/auth_screen.dart';
import 'package:sama_taxi/features/auth/presentation/auth_viewmodel.dart';
import 'package:sama_taxi/features/auth/presentation/screens/forget_password.dart';
import 'package:sama_taxi/features/auth/presentation/screens/login.dart';
import 'package:sama_taxi/features/auth/presentation/screens/signup_screen.dart';
import 'package:sama_taxi/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:sama_taxi/features/auth/presentation/widgets/splash.dart';
import 'package:sama_taxi/features/home/presentation/home_screen.dart';
import 'package:sama_taxi/features/lists/presentation/visits_screen.dart';
import 'package:sama_taxi/features/location/presentation/screens/add_new_location_screen.dart';
import 'package:sama_taxi/features/offers/presentation/screens/offers_screen.dart';
import 'package:sama_taxi/features/outstation/presentation/screens/outstation_booking_screen.dart';
import 'package:sama_taxi/features/settings/presentation/screens/settings_screen.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/categories_screen.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/taxify_home_screen.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/vehicle_selection_screen.dart';
import 'package:sama_taxi/features/wallet/presentation/screens/wallect_screen.dart';

/// Application routes
class AppRoutes {
  // Auth
 // static const String splash = '/';
  static const String onboarding = '/onboarding';
  // static const String login = '/login';
  // static const String auth = '/auth';
  //   static const String signUp = '/signup';
  // static const String verifyOtp = '/verify-otp';
  // static const String forgotPassword = '/forgot-password';
  // static const String resetPassword = '/reset-password';
  // Main Tabs
  static const String home = '/home';
  static const String lists = '/lists';
  static const String offers = '/offers';
  static const String settings = '/settings';
  
  // List Categories
  static const String listCategories = '$lists/categories';
  static const String listPackages = '$lists/packages';
  static const String listTours = '$lists/tours';
  static const String listVisits = '$lists/visits';
  
  // Taxify
  static const String taxifyHome = '/taxify';
  static const String taxifyCategories = '$taxifyHome/categories';
  static const String vehicleSelection = '$taxifyHome/vehicle-selection';
  
  // Outstation
  static const String outstationBooking = '/outstation/booking';
  
  // Location
  static const String addLocation = '/location/add';
  static const String addNewLocation = '/add-new-location';
  static const String mapSelection = '/map-selection';
  // Settings
  static const String helpCenter = '$settings/help-center';
  static const String notifications = '$settings/notifications';
  
  // Visits
  static const String visitDetails = '/visits/:id';
  
  // Offers
  static const String offerDetails = '$offers/:id';
  
  // Wallet
  static const String wallet = '/wallet';
  static const String walletTransactions = '$wallet/transactions';
}

/// Router provider for dependency injection
final routerProvider = Provider<GoRouter>((ref) {
  // Watch auth state to make router reactive to changes
 // final authState = ref.watch(authViewModelProvider);
  
  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    debugLogDiagnostics: true,
    redirect: (context, state) => _handleRedirect(ref, state),
    routes: [

  
    // ... existing routes ...
    
    // Auth routes
    // GoRoute(
    //     path: AppRoutes.auth,
    //     name: 'auth',
    //     builder: (context, state) => const AuthScreen(),
    //   ),
    //    GoRoute(
    //     path: AppRoutes.login,
    //     name: 'login',
    //     builder: (context, state) => const LoginScreen(),
    //   ),
      
    //    GoRoute(
    //     path: AppRoutes.login,
    //     name: 'forget-password',
    //     builder: (context, state) => const ForgotPasswordScreen(),
    //   ),
      
    // GoRoute(
    //   path: AppRoutes.signUp,
    //   name: 'signup',
    //   builder: (context, state) => const SignUpScreen(),
    // ),
    // GoRoute(
    //   path: AppRoutes.verifyOtp,
    //   name: 'verify-otp',
    //   builder: (context, state) {
    //     final email = state.uri.queryParameters['email'] ?? '';
    //     return VerifyOtpScreen(email: email);
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.forgotPassword,
    //   name: 'forgot-password',
    //   builder: (context, state) => const ForgotPasswordScreen(),
    // ),
   
    
    // ... rest of your routes ...

      // Auth Flow
      // GoRoute(
      //   path: AppRoutes.splash,
      //   name: 'splash',
      //   builder: (context, state) => const SplashScreen(),
      // ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      
      // Main Tabs
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      
      // Lists Section
      GoRoute(
        path: AppRoutes.listCategories,
        name: 'list-categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
      // GoRoute(
      //   path: AppRoutes.listPackages,
      //   name: 'list-packages',
      //   builder: (context, state) => const PackagesScreen(),
      // ),
      // GoRoute(
      //   path: AppRoutes.listTours,
      //   name: 'list-tours',
      //   builder: (context, state) => const ToursScreen(),
      // ),
      GoRoute(
        path: AppRoutes.listVisits,
        name: 'list-visits',
        builder: (context, state) => const VisitsScreen(),
      ),
      
      // Taxify Flow
      GoRoute(
        path: AppRoutes.taxifyHome,
        name: 'taxify-home',
        builder: (context, state) => const SamaHomeScreen(),
        routes: [
          GoRoute(
            path: 'categories',
            name: 'taxify-categories',
            builder: (context, state) => const CategoriesScreen(),
          ),
          GoRoute(
            path: 'vehicle-selection',
            name: 'vehicle-selection',
            builder: (context, state) => const VehicleSelectionScreen(),
          ),
        ],
      ),
      
      // Outstation Booking
    GoRoute(
  path: AppRoutes.outstationBooking,
  name: 'outstation-booking',
  builder: (context, state) => const OutstationBookingScreen(),
  redirect: (context, state) {
    //final authState = ref.read(authViewModelProvider);
    // Allow access to outstation booking even if not authenticated
    // You can add additional checks here if needed
    return null; // No redirect
  },
),
      
      // Wallet
      GoRoute(
        path: AppRoutes.wallet,
        name: 'wallet',
        builder: (context, state) => const WalletScreen(),
      ),
      // GoRoute(
      //   path: AppRoutes.walletTransactions,
      //   name: 'wallet-transactions',
      //   builder: (context, state) => const WalletTransactionsScreen(),
      // ),
      
      // Location
      // GoRoute(
      //   path: AppRoutes.addLocation,
      //   name: 'add-location',
      //   builder: (context, state) => const AddLocationScreen(),
      // ),
      
      // new location
 GoRoute(
        path: AppRoutes.addNewLocation,
        name: 'add-new-location',
        builder: (context, state) => const AddNewLocationScreen(),
      ),
      
      
//       // Settings
//       GoRoute(
//   path: AppRoutes.settings,
//   name: 'settings',
//   pageBuilder: (context, state) => const MaterialPage(
//     child: ProfileScreen(),
//   ),
// ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
        // routes: [
        //   GoRoute(
        //     path: 'help-center',
        //     name: 'help-center',
        //     builder: (context, state) => const HelpCenterScreen(),
        //   ),
        //   GoRoute(
        //     path: 'notifications',
        //     name: 'notifications-settings',
        //     builder: (context, state) => const NotificationsSettingsScreen(),
        //   ),
        // ],
      ),
      
      // Offers
      GoRoute(
        path: AppRoutes.offers,
        name: 'offers',
        builder: (context, state) => const OffersScreen(),
      ),
      // GoRoute(
      //   path: AppRoutes.offerDetails,
      //   name: 'offer-details',
      //   builder: (context, state) {
      //     final offerId = state.pathParameters['id']!;
      //     return OfferDetailsScreen(offerId: offerId);
      //   },
      // ),
      
      // Visits
      // GoRoute(
      //   path: AppRoutes.visitDetails,
      //   name: 'visit-details',
      //   builder: (context, state) {
      //     final visitId = state.pathParameters['id']!;
      //     return VisitDetailsScreen(visitId: visitId);
      //   },
      // ),
    
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});


/// Navigation extensions for easier usage
/// /// Navigation extensions for easier usage with go_router
extension AppNavigation on BuildContext {

  /* =======================
   * ROOT / REPLACE ROUTES
   * ======================= */

  // App entry & auth flow
 // void goToSplash() => go(AppRoutes.splash);
  void goToOnboarding() => go(AppRoutes.onboarding);
 

  
  // Auth Navigation
  // void goToAuth() => go(AppRoutes.auth);
//  void goToSignUp() => go(AppRoutes.signUp);
  
//   void goToVerifyOtp({required String email}) => 
//       go('${AppRoutes.verifyOtp}?email=${Uri.encodeComponent(email)}');
  
//   void goToForgotPassword() => go(AppRoutes.forgotPassword);
  
//   void goToResetPassword({required String token, required String email}) => 
//       go('${AppRoutes.resetPassword}?token=${Uri.encodeComponent(token)}&email=${Uri.encodeComponent(email)}');
  
//   // ... rest of your navigation methods ...

// void goToLogin() => go(AppRoutes.login);
  // Main roots
  void goToHome() => go(AppRoutes.home);
  void goToTaxifyHome() => go(AppRoutes.taxifyHome);

  /* =======================
   * PUSH ROUTES (BACK ENABLED)
   * ======================= */

  // Lists
  void pushListCategories() => push(AppRoutes.listCategories);
  void pushListPackages() => push(AppRoutes.listPackages);
  void pushListTours() => push(AppRoutes.listTours);
  void pushListVisits() => push(AppRoutes.listVisits);

  // Taxify
  void pushTaxifyCategories() => push(AppRoutes.taxifyCategories);
  void pushVehicleSelection() => push(AppRoutes.vehicleSelection);

  // Outstation
  void pushOutstationBooking() => push(AppRoutes.outstationBooking);

  // Location
 // void pushAddLocation() => push(AppRoutes.addLocation);
  void pushNewLocation() => push(AppRoutes.addNewLocation);
  void pushMapSelection() => push(AppRoutes.mapSelection);

  // Settings
  void pushSettings() => push(AppRoutes.settings);
  void pushHelpCenter() => push(AppRoutes.helpCenter);
  void pushNotificationsSettings() => push(AppRoutes.notifications);

  // Offers
  void pushOffers() => push(AppRoutes.offers);
  void pushOfferDetails(String offerId) =>
      push('${AppRoutes.offers}/$offerId');

  // Visits
  void pushVisitDetails(String visitId) =>
      push('/visits/$visitId');

  /* =======================
   * BACK / POP
   * ======================= */

  void goBack<T extends Object?>([T? result]) => pop<T>(result);

  /* =======================
   * UTILITIES
   * ======================= */

  bool isCurrentRoute(String routeName) =>
      GoRouterState.of(this).matchedLocation == routeName;
}
/// Handle navigation redirects based on app state
String? _handleRedirect(Ref ref, GoRouterState state) {
  final authState = ref.read(authViewModelProvider);
  final currentLocation = state.matchedLocation;

  // Skip auth check for public routes
  if (_isPublicRoute(currentLocation)) {
    return null; // Allow access to public routes
  }

  // IfAppAssets.carLogo, redirect to login
  if (!authState.isAuthenticated) {
   // return AppRoutes.login;
     return AppRoutes.home;
  }

  return null; // Allow access to all other routes if authenticated
}

bool _isPublicRoute(String? location) {
  if (location == null) return false;
  
  final publicRoutes = [
    AppRoutes.onboarding,
    // AppRoutes.auth,
    // AppRoutes.login,  // Add login to public routes
    // AppRoutes.signUp,
    // AppRoutes.verifyOtp,
    // AppRoutes.forgotPassword,
    // AppRoutes.resetPassword,
    AppRoutes.home,   // Consider if home should be public or not
    AppRoutes.outstationBooking,
  ];
  
  return publicRoutes.any((route) => location.startsWith(route));
}