import 'package:flutter/material.dart';
import 'package:sama_taxi/core/navigation/app_router.dart';
import 'package:sama_taxi/features/home/presentation/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
 with SingleTickerProviderStateMixin{
  final PageController _pageController = PageController(viewportFraction: 0.9);
late AnimationController _controller;
late Animation<double> _animation;
 // final List<String> carImages = List.filled(1, 'assets/images/car-logo.png');

@override
void initState() {
  super.initState();

  _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();

  _animation = Tween<double>(
    begin: 1.2, // starts OFF the right side
    end: -0.3,  // ends OFF the left side
  ).animate(_controller)
    ..addListener(() {
      setState(() {});
    });
}


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(seconds: 15),
          curve: Curves.slowMiddle,
        );
        _startAutoScroll();
      }
    }); 
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // TOP SECTION WITH CAR IMAGE AND DARK BACKGROUND
          Container(
          //  color: Colors.green,
            height: 560,
            child: Expanded(
              child: Stack(
                children: [
                  // Background
                  Container(
                    height: 400,
                   decoration: BoxDecoration(
                   color:  Colors.grey,
                   borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200)
                   )
                   ),
                   // width: double.infinity,
                  ),
                     
                  // Car and motorcycles
                  Stack(               
                    children: [
                  
                      // Left motorcycle
                      Positioned(
                        right: -20,
                        top: 20,                   
                        child:  Transform.rotate(
                            angle: 0.9,
                          child: Image.asset(
                             width: 140,
                            'assets/images/car-logo.png' ),
                        ),
                        ),                                                 
                      // Right motorcycle
                      Positioned(
                          
                        top: 20,
                        left: -20,
                       
                          child:  Transform.rotate(
                            angle: -0.9,
                            child: Image.asset(
                                width: 140,
                            'assets/images/car-logo.png' ,
                            
                                                  ),
                          ),
                      ),
                     // TAXI text on car
                  Positioned(
                  left: -MediaQuery.of(context).size.width,
                  right: -MediaQuery.of(context).size.width,
              top: 160,// 
              child: SizedBox(
                height: 300, 
                child:Transform.flip(
                  flipX: true,
                  child:
                Image.asset(
                    'assets/images/car-logo.png',
                    width: 120,
                      )    ))   ),
            
            
                     Positioned(
              top:320,  // Moved up slightly to accommodate larger size
              left: MediaQuery.of(context).size.width * _animation.value,
              child: SizedBox(
                height: 400,  // Increased from 300 to 400
                child: Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    'assets/images/car-logo.png',
                    width: 300,  // Increased from 200 to 300
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
                  
                    ],
                  ),
                ],
              ),
            ),
          ),
         
          // Bottom content section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),  // Increased top padding
              child:// Bottom content card with title, description, and navigation
Container(
  height: MediaQuery.of(context).size.height * 0.6,
  decoration: BoxDecoration(
    color: Colors.white,
    border: Border(
      top: BorderSide(
        color: Colors.grey.shade300,
        width: 1.0,
      ),
    ),
  ),
  child: Padding(
    padding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Content Section
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
  onboardingData[currentPage]['title'] as String,
  style: const TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    letterSpacing: 0.5,
  ),
  textAlign: TextAlign.center,
),

const SizedBox(height: 24.0),

// Description
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: Text(
    onboardingData[currentPage]['description'] as String,
    style: const TextStyle(
      fontSize: 16.0,
      color: Colors.grey,
      height: 1.6,
    ),
    textAlign: TextAlign.center,
  ),
),
              ],
            ),
          ),
        ),

        // Bottom Navigation Section
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
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
                      if(currentPage<onboardingData.length-1){
                        currentPage++;
                      }
                      else if(currentPage==onboardingData.length){
                    
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => HomeScreen()));
    
                      }    
                      // Handle next button press
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
                      ),
          )
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
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
    'image': 'assets/images/onboarding1.png', // Replace with your actual image path
    'indicatorIndex': 0,
  },
  {
    'title': 'Fast & Reliable Service',
    'description': 'Get to your destination quickly with our network of professional drivers. Real-time tracking ensures you\'re always in the know.',
    'image': 'assets/images/onboarding2.png', // Replace with your actual image path
    'indicatorIndex': 1,
  },
  {
    'title': 'Easy Booking',
    'description': 'Book your ride in just a few taps. Our simple interface makes getting around town effortless and convenient.',
    'image': 'assets/images/onboarding3.png', // Replace with your actual image path
    'indicatorIndex': 2,
  },
];
int currentPage = 0; 
}