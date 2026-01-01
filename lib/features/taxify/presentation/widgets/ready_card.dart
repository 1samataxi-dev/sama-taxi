import 'package:flutter/material.dart';
import 'package:sama_taxi/core/assets/app_assets.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/vehicle_selection_screen.dart';

class ReadyCard extends StatelessWidget {
  const ReadyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VehicleSelectionScreen(),
                      ),
                    );
                  },
      child: Stack(
        children: [
          Container(
            height: 160,
            width: 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ready?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Then let\'s roll now.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  AppAssets.carLogo,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
