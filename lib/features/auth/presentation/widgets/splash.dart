

import 'package:flutter/material.dart';
import 'package:sama_taxi/core/assets/app_assets.dart';
import 'package:sama_taxi/core/navigation/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 1.2,
      end: -0.3,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {
          currentPage = _pageController.page!.toInt();
        });
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top section with car animation
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.62,
            child: Stack(
              children: [
                // Background
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                ),
                     
                // Car and motorcycles
                Stack(               
                  children: [
                    // Left motorcycle
                    Positioned(
                      right: -20,
                      top: 20,                   
                      child: Transform.rotate(
                        angle: 0.9,
                        child: Image.asset(
                          width: 140,
                          AppAssets.carLogo,
                        ),
                      ),
                    ),                                                 
                    // Right motorcycle
                    Positioned(
                      top: 20,
                      left: -20,
                      child: Transform.rotate(
                        angle: -0.9,
                        child: Image.asset(
                          width: 140,
                          AppAssets.carLogo,
                        ),
                      ),
                    ),
                    // TAXI text on car
                    Positioned(
                      left: -MediaQuery.of(context).size.width,
                      right: -MediaQuery.of(context).size.width,
                      top: 160,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.33, 
                        child: Transform.flip(
                          flipX: true,
                          child: Image.asset(
                            AppAssets.carLogo,
                            width: 120,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 320,
                      left: MediaQuery.of(context).size.width * _animation.value,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Transform.flip(
                          flipX: true,
                          child: Image.asset(
                            AppAssets.carLogo,
                            width: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
         
          // Bottom content section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // PageView for onboarding content
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: onboardingData.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 24.0,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  onboardingData[index]['title'],
                                  style: const TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    letterSpacing: 0.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  onboardingData[index]['description'] as String,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    height: 1.6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Bottom Navigation Section
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Page Indicators
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            onboardingData.length, 
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: _buildPageIndicator(index == currentPage),
                            ),
                          ),
                        ),
                        
                        // Next Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30.0),
                              onTap: () {
                                if (currentPage < onboardingData.length-1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                debugPrint('Current Page: $currentPage');
                                } else {
                                  context.goToHome();
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  final List<Map<String, dynamic>> onboardingData = [
    {
      'title': 'Affordable Rides for All',
      'description': 'Choose from a variety of ride options to fit your budget. Affordable and reliable rides are just a tap away.',
      'image': 'assets/images/onboarding1.png',
      'indicatorIndex': 0,
    },
    {
      'title': 'Fast & Reliable Service',
      'description': 'Get to your destination quickly with our network of professional drivers. Real-time tracking ensures you\'re always in the know.',
      'image': 'assets/images/onboarding2.png',
      'indicatorIndex': 1,
    },
    {
      'title': 'Easy Booking',
      'description': 'Book your ride in just a few taps. Our simple interface makes getting around town effortless and convenient.',
      'image': 'assets/images/onboarding3.png',
      'indicatorIndex': 2,
    },
  ];
}