import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sama_taxi/features/auth/presentation/auth_viewmodel.dart';
import 'package:sama_taxi/features/auth/presentation/widgets/splash.dart';
import 'package:sama_taxi/features/home/presentation/home_screen.dart';
import 'package:sama_taxi/features/lists/presentation/categories_screen.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/categories_screen.dart';
import 'package:sama_taxi/features/outstation/presentation/screens/outstation_booking_screen.dart';

/// Application routes
class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  //static const String auth = '/auth';
  static const String home = '/home';
  static const String category = '/category';
  static const String outstationBooking = '/outstation-booking';
}

/// Router provider for dependency injection
final routerProvider = Provider<GoRouter>((ref) {
  // Watch auth state to make router reactive to changes
  ref.watch(authViewModelProvider);
  //ref.watch(onboardingProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) => _handleRedirect(ref, state),
    routes: [
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
      // GoRoute(
      //   path: AppRoutes.auth,
      //   name: 'auth',
      //   builder: (context, state) => const AuthScreen(),
      // ),  
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      // GoRoute(
      //   path: AppRoutes.home,
      //   name: 'sama-home',
      //   builder: (context, state) => const SamaHomeScreen(),
     
      // ),
       GoRoute(
        path: AppRoutes.category,
        name: 'category',
        builder: (context, state) => const CategoriesScreen(),
          routes: [
          GoRoute(
            path: 'outstation-booking',
            name: 'outstation-booking',
            builder: (context, state) {
              final visit = state.extra as TopCategories?;
              if (visit == null) {
                // Handle error case - redirect to home
                return const CategoriesScreen();
              }
              return OutstationBookingScreen();
            },
          ),
        ],
          ),
     
         
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

/// Handle navigation redirects based on app state
String? _handleRedirect(Ref ref, GoRouterState state) {
  // Use watch instead of read to make redirect reactive to state changes
  final authState = ref.watch(authViewModelProvider);
  //final onboardingState = ref.watch(onboardingProvider);
  final currentLocation = state.matchedLocation;

  // Debug logging
  print('🔄 Router Redirect Check:');
  print('  Current Location: $currentLocation');
  print('  Auth Loading: ${authState.isLoading}');
  print('  Auth Authenticated: ${authState.isAuthenticated}');
  print('  Auth Customer: ${authState.customer?.fullname ?? 'null'}');
  // print('  Onboarding Loading: ${onboardingState.isLoading}');
  // print('  Onboarding Completed: ${onboardingState.hasCompletedOnboarding}');

  // Show splash while loading
  // if (authState.isLoading || onboardingState.isLoading) {
  //   print('  ➡️ Redirecting to splash (loading)');
  //   return currentLocation == AppRoutes.splash ? null : AppRoutes.splash;
  // }

  // // Redirect to onboarding if not completed
  // if (!onboardingState.hasCompletedOnboarding) {
  //   print('  ➡️ Redirecting to onboarding');
  //   return currentLocation == AppRoutes.onboarding
  //       ? null
  //       : AppRoutes.onboarding;
  // }

  // Redirect based on authentication status
  final isAuthenticated =
      authState.isAuthenticated && authState.customer != null;

  if (!isAuthenticated) {
    // User not authenticated - redirect to auth unless already there
    print('  ➡️ Redirecting to auth (not authenticated)');
    return currentLocation == AppRoutes.home ? null : AppRoutes.home;
  } else {
    // User authenticated - redirect to home if on auth/onboarding/splash
    // if (currentLocation == AppRoutes.auth ||
    //     currentLocation == AppRoutes.onboarding ||
    //     currentLocation == AppRoutes.splash) {
    //   print('  ➡️ Redirecting to home (authenticated)');
    //   return AppRoutes.home;
    // }
  }

  // No redirect needed
  print('  ✅ No redirect needed');
  return null;
}

/// Navigation extensions for easier usage
extension AppNavigation on BuildContext {
  /// Navigate to visit details
  // void goToVisitDetails(Visit visit) {
  //   go('${AppRoutes.home}/visit-details', extra: visit);
  // }

  /// Navigate to home
  void goToHome() {
    go(AppRoutes.home);
  }

  /// Navigate to auth
  // void goToAuth() {
  //   go(AppRoutes.auth);
  // }

  /// Navigate to onboarding
  void goToOnboarding() {
    go(AppRoutes.onboarding);
  }

  /// Navigate to outstation booking
  void goToOutstationBooking() {
    go(AppRoutes.outstationBooking);
  }
}
