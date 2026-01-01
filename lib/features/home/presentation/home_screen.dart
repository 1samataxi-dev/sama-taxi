import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/features/auth/presentation/auth_viewmodel.dart';
import 'package:sama_taxi/features/home/presentation/utils/home_constants.dart';
import 'package:sama_taxi/features/home/presentation/widgets/widgets.dart';
import 'package:sama_taxi/features/lists/presentation/visits_screen.dart';
import 'package:sama_taxi/features/profile/setting/profile_screen.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/categories_screen.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/taxify_home_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;

  final List<Widget> _screens = [
    //HotelsScreen(),
    // PackagesScreen(),
    // ToursScreen(),
    const SamaHomeScreen(),
    const CategoriesScreen(),
  //  MapSelectionScreen(onLocationSelected: (LocationModel location) {
      
   // }),
    VisitsScreen(),
    const ProfileScreen(),
  //  SettingsScreen(),
   
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    // Start the initial animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes for logout feedback
    ref.listen(authViewModelProvider, (previous, next) {
      // Show logout success message
      if (previous?.isAuthenticated == true &&
          !next.isAuthenticated &&
          !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Successfully logged out'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }

      // Show logout error if any
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    });

    return Scaffold(
   //   appBar: HomeAppBar(title: _getTitle()),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.02, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.98, end: 1).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: child,
              ),
            ),
          ),
          child: HomeBody(
            key: ValueKey(_currentIndex),
            child: _screens[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 32,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: CustomBottomNavigation(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              // Add haptic feedback
              HapticFeedback.lightImpact();
              setState(() {
                _currentIndex = index;
              });
              // Restart animation for smooth transition
              _animationController
                ..reset()
                ..forward();
            }
          },
          iconPaths: HomeConstants.iconPaths,
          labels: _getTabLabels(),
          animationController: _animationController,
        ),
      ),
     
    );
  }

  // String _getTitle() {
  //   switch (_currentIndex) {
  //     case HomeConstants.homeIndex:
  //       return AppStrings.home.tr();
  //     case HomeConstants.categoryIndex:
  //       return AppStrings.categories.tr();
  //     case HomeConstants.ridesIndex:
  //       return AppStrings.myRides.tr();
  //     case HomeConstants.settingIndex:
  //       return AppStrings.settings.tr();
  //     default:
  //       return AppStrings.appName.tr();
  //   }
  // }

  List<String> _getTabLabels() => [
    AppStrings.home.tr(),
    AppStrings.categories.tr(),
    AppStrings.tours.tr(),
    AppStrings.settings.tr(),

  ];
}
