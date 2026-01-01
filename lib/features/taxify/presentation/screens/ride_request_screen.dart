import 'package:flutter/material.dart';
import 'package:sama_taxi/core/theme/colors.dart';
import 'package:sama_taxi/features/taxify/domain/models/ride_request_model.dart';

class RideRequestBottomSheet extends StatefulWidget {
  const RideRequestBottomSheet({super.key});

  @override
  State<RideRequestBottomSheet> createState() => _RideRequestBottomSheetState();
}

class _RideRequestBottomSheetState extends State<RideRequestBottomSheet> {
  final List<RideRequest> sampleRequests = [
    RideRequest(
      id: '1',
      driverName: 'Jonathan Higgins',
      carModel: 'Tesla Model 3',
      rating: 4.8,
      ratingCount: 127,
      price: 266,
      estimatedTime: const Duration(minutes: 6),
      distance: 2.0,
      driverImageUrl: '',
    ),
    RideRequest(
      driverImageUrl: '',
      id: '2',
      driverName: 'Sarah Johnson',
      carModel: 'Toyota Camry',
      rating: 4.9,
      ratingCount: 89,
      price: 189,
      estimatedTime: const Duration(minutes: 8),
      distance: 3.0,
    ),
    RideRequest(
      id: '3',
      driverName: 'Peter Wilson',
      carModel: 'Audi A4',
      rating: 4.7,
      ratingCount: 120,
      price: 250,
      estimatedTime: const Duration(minutes: 7),
      distance: 3.5,
      driverImageUrl: '',
    ),
    RideRequest(
      driverImageUrl: '',
      id: '4',
      driverName: 'Alexandra Brown',
      carModel: 'Honda Civic',
      rating: 4.6,
      ratingCount: 80,
      price: 200,
      estimatedTime: const Duration(minutes: 9),
      distance: 4.0,
    ),
    
    RideRequest(
      driverImageUrl: '',
      id: '5',
      driverName: 'Michael Davis',
      carModel: 'BMW X3',
      rating: 4.5,
      ratingCount: 65,
      price: 320,
      estimatedTime: const Duration(minutes: 10),
      distance: 5.0,
    ),
  ];

  // // Function to show the bottom sheet
  // static Future<void> showDialog(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => const RideRequestBottomSheet(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return 
    
    
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Expanded(
        child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Title
            const Text(
              'Available Rides',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Ride requests list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sampleRequests.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildRideRequestCard(
                  rideRequest: sampleRequests[index],
                  onAccept: () {
                    // Handle accept
                    Navigator.pop(context, sampleRequests[index]);
                  },
                  onSkip: () {
                    // Handle skip
                    if (index < sampleRequests.length - 1) {
                      // Show next request if available
                      setState(() {
                        sampleRequests.removeAt(index);
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
        ),
      )
    );
  }

  Widget _buildRideRequestCard({
    required RideRequest rideRequest,
    required VoidCallback onAccept,
    required VoidCallback onSkip,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Driver info row
          Row(
            children: [
              // Driver avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 30, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              
              // Driver details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rideRequest.carModel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      rideRequest.driverName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rideRequest.rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${rideRequest.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${rideRequest.estimatedTime.inMinutes} min • ${rideRequest.distance} km',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onSkip,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}