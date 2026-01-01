// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:sama_taxi/core/constants/app_colors.dart';
// import 'package:sama_taxi/features/taxify/domain/models/ride_request_model.dart';

// class RideInProgressScreen extends StatefulWidget {
//   final String driverName;
//   final String carModel;
//   final String licensePlate;
//   final double rating;
//   final String eta;

//   const RideInProgressScreen({
//     Key? key,
//     required this.driverName,
//     required this.carModel,
//     required this.licensePlate,
//     this.rating = 4.8,
//     required this.eta,
//   }) : super(key: key);

//   @override
//   State<RideInProgressScreen> createState() => _RideInProgressScreenState();
// }

// class _RideInProgressScreenState extends State<RideInProgressScreen> {

// //   late Timer _timer;

// // @override
// // void initState() {
// //   super.initState();
// //   print('RideInProgressScreen - initState');
// //   _timer = Timer( Duration(seconds: 5), () {
// //     print('Timer completed, navigating to RideRequestScreen');
   
// //      //   show(context);
    
// // });
  
// // }
// // @override
// // void dispose() {
// //   print('RideInProgressScreen - dispose');
// //   _timer.cancel();
// //   super.dispose();
// // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Map View (Placeholder)
//           Container(
//             color: Colors.grey[200],
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(
//                     Icons.location_on,
//                     size: 40,
//                     color: AppColors.primary,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Map View',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Slide to cancel button
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 40,
//             child: _buildSlideToCancelButton(context),
//           ),

//           // Driver info card
//           Positioned(
//             top: 60,
//             left: 16,
//             right: 16,
//             child: _buildDriverInfoCard(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDriverInfoCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               // Driver avatar
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: AppColors.primary.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.person,
//                   size: 30,
//                   color: AppColors.primary,
//                 ),
//               ),
//               const SizedBox(width: 12),
              
//               // Driver info
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.driverName,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${widget.carModel} • ${widget.licensePlate}',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
              
//               // Rating
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: AppColors.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.star,
//                       size: 16,
//                       color: Colors.amber,
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       widget.rating.toString(),
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
          
//           // ETA and distance
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildInfoChip(
//                 icon: Icons.access_time,
//                 label: 'ETA',
//                 value: widget.eta,
//               ),
//               _buildInfoChip(
//                 icon: Icons.directions_car,
//                 label: 'Distance',
//                 value: '2.5 km',
//               ),
//               _buildInfoChip(
//                 icon: Icons.payments,
//                 label: 'Fare',
//                 value: '\$12.50',
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoChip({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 16, color: AppColors.primary),
//           const SizedBox(width: 4),
//           Text(
//             '$label: $value',
//             style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSlideToCancelButton(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: GestureDetector(
//         onHorizontalDragUpdate: (details) {
//           // Handle swipe to cancel
//         },
//         onHorizontalDragEnd: (details) {
//           // Show confirmation dialog when swiped
//           if (details.primaryVelocity! > 100) { // Swiped right
//             _showCancelConfirmationDialog(context);
//           }
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.arrow_back_ios,
//                 size: 16,
//                 color: Colors.red,
//               ),
//               const SizedBox(width: 8),
//               const Text(
//                 'Slide to cancel ride',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCancelConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Cancel Ride'),
//         content: const Text('Are you sure you want to cancel this ride?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () {
//                 Navigator.pop(context); // Close dialog
//   Navigator.of(context).pop(); //
      
//           // Go back to previous screen
//               // TODO: Add cancellation logic
//             },
//             child: const Text(
//               'Yes, cancel',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//    final List<RideRequest> sampleRequests = [
//     RideRequest(
//       id: '1',
//       driverName: 'Jonathan Higgins',
//       carModel: 'Tesla Model 3',
//       rating: 4.8,
//       ratingCount: 127,
//       price: 266,
//       estimatedTime: const Duration(minutes: 6),
//       distance: 2.0,
//       driverImageUrl: '',
//     ),
//     RideRequest(
//       driverImageUrl: '',
//       id: '2',
//       driverName: 'Sarah Johnson',
//       carModel: 'Toyota Camry',
//       rating: 4.9,
//       ratingCount: 89,
//       price: 189,
//       estimatedTime: const Duration(minutes: 8),
//       distance: 3.0,
//     ),
//   ];

//   // Function to show the bottom sheet
//    Future<void> show(BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => buildRidesList(context),
//     );
//   }



//   Widget buildRidesList(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         left: 16,
//         right: 16,
//         top: 16,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Drag handle
//           Container(
//             width: 40,
//             height: 4,
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
          
//           // Title
//           const Text(
//             'Available Rides',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
          
//           // Ride requests list
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: sampleRequests.length,
//             itemBuilder: (context, index) => Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: _buildRideRequestCard(
//                 rideRequest: sampleRequests[index],
//                 onAccept: () {
//                   // Handle accept
//                   Navigator.pop(context, sampleRequests[index]);
//                 },
//                 onSkip: () {
//                   // Handle skip
//                   if (index < sampleRequests.length - 1) {
//                     // Show next request if available
//                     setState(() {
//                       sampleRequests.removeAt(index);
//                     });
//                   } else {
//                     Navigator.pop(context);
//                   }
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }

//   Widget _buildRideRequestCard({
//     required RideRequest rideRequest,
//     required VoidCallback onAccept,
//     required VoidCallback onSkip,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Driver info row
//           Row(
//             children: [
//               // Driver avatar
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.person, size: 30, color: Colors.grey),
//               ),
//               const SizedBox(width: 12),
              
//               // Driver details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       rideRequest.carModel,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       rideRequest.driverName,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         const Icon(Icons.star, color: Colors.amber, size: 16),
//                         const SizedBox(width: 4),
//                         Text(
//                           rideRequest.rating.toString(),
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
              
//               // Price
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '₹${rideRequest.price.toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${rideRequest.estimatedTime.inMinutes} min • ${rideRequest.distance} km',
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
          
//           const SizedBox(height: 16),
          
//           // Action buttons
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: onSkip,
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     side: const BorderSide(color: Colors.grey),
//                   ),
//                   child: const Text(
//                     'Skip',
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: onAccept,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Accept',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

