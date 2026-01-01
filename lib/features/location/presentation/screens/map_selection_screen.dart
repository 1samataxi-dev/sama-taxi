// import 'dart:io' show Platform;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sama_taxi/core/constants/app_colors.dart';
// import 'package:sama_taxi/core/widgets/custom_button.dart';
// import 'package:sama_taxi/features/location/domain/models/location_model.dart';

// // Conditional import for Google Maps
// bool get isGoogleMapsAvailable {
//   try {
//     // This will throw an error if the platform is not supported
//     if (Platform.isAndroid || Platform.isIOS) {
//       return true;
//     }
//     return false;
//   } catch (e) {
//     return false;
//   }
// }

// class MapSelectionScreen extends ConsumerStatefulWidget {
//   final LocationModel? initialLocation;
//   final Function(LocationModel) onLocationSelected;

//   const MapSelectionScreen({
//     Key? key,
//     this.initialLocation,
//     required this.onLocationSelected,
//   }) : super(key: key);

//   @override
//   ConsumerState<MapSelectionScreen> createState() => _MapSelectionScreenState();
// }

// class _MapSelectionScreenState extends ConsumerState<MapSelectionScreen> {
//   // Fallback position (New York City)
//   static const double _defaultLatitude = 40.7128;
//   static const double _defaultLongitude = -74.0060;
  
//   // Current position
//   double? _currentLat;
//   double? _currentLng;
  
//   // UI state
//   final TextEditingController _searchController = TextEditingController();
//   bool _isLoading = true;
//   String? _errorMessage;
//   final List<String> _suggestions = [
//     'University of Washington',
//     'Woodland Park',
//     'Husky Sta',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
  
//   Future<void> _getCurrentLocation() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       // Check if location services are enabled
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         setState(() {
//           _errorMessage = 'Location services are disabled. Please enable them to continue.';
//           _isLoading = false;
//         });
//         return;
//       }

//       // Check location permission
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           setState(() {
//             _errorMessage = 'Location permissions are required to find your current location.';
//             _isLoading = false;
//           });
//           return;
//         }
//       }
      
//       if (permission == LocationPermission.deniedForever) {
//         setState(() {
//           _errorMessage = 'Location permissions are permanently denied. Please enable them in app settings.';
//           _isLoading = false;
//         });
//         return;
//       }

//       // Get current position
//       final position = await Geolocator.getCurrentPosition();
//       setState(() {
//         _currentLat = position.latitude;
//         _currentLng = position.longitude;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Could not get your current location. Using default location.';
//         _isLoading = false;
//       });
//     }
//   }

//   Widget _buildMapView() {
//     if (!isGoogleMapsAvailable) {
//       return _buildMapPlaceholder();
//     }
    
//     return FutureBuilder<bool>(
//       future: Future.value(true), // Simulate async operation
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
        
//         try {
//           // Dynamically import Google Maps
//           final googleMaps = isGoogleMapsAvailable ? 
//             const MethodChannel('plugins.flutter.io/google_maps') : null;
            
//           if (googleMaps == null) {
//             return _buildMapPlaceholder();
//           }
          
//           // Use the Google Maps widget
//           return GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: LatLng(
//                 _currentLat ?? _defaultLatitude,
//                 _currentLng ?? _defaultLongitude,
//               ),
//               zoom: 14.0,
//             ),
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             onMapCreated: (controller) {
//               // _mapController = controller;
//             },
//           );
//         } catch (e) {
//           return _buildMapPlaceholder();
//         }
//       },
//     );
//   }
  
//   Widget _buildMapPlaceholder() {
//     return Container(
//       color: Colors.grey[200],
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.map, size: 64, color: Colors.grey),
//             const SizedBox(height: 16),
//             Text(
//               'Map not available on this device',
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
    
//     if (_errorMessage != null) {
// //       return @override
// // Widget build(BuildContext context) {
//   return Scaffold(
//     body: Stack(
//       children: [
//         // Map View (shows placeholder if error occurs)
//         _buildMapView(),

//         // Top App Bar
//         Positioned(
//           top: MediaQuery.of(context).padding.top + 16,
//           left: 16,
//           right: 16,
//           child: Row(
//             children: [
//               // Back Button
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.black),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               // Search Bar
//               Expanded(
//                 child: Container(
//                   height: 50,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: InputDecoration(
//                       hintText: 'Search for a location',
//                       border: InputBorder.none,
//                       suffixIcon: const Icon(Icons.search, color: Colors.grey),
//                       contentPadding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Current Location Button
//         Positioned(
//           bottom: 200,
//           right: 16,
//           child: FloatingActionButton(
//             onPressed: () {
//               // TODO: Center map on current location
//             },
//             backgroundColor: Colors.white,
//             child: const Icon(Icons.my_location, color: Colors.black),
//           ),
//         ),

//         // Bottom Sheet
//         DraggableScrollableSheet(
//           initialChildSize: 0.3,
//           minChildSize: 0.3,
//           maxChildSize: 0.6,
//           builder: (context, scrollController) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 20,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // Drag Handle
//                   Container(
//                     margin: const EdgeInsets.only(top: 12, bottom: 8),
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
                  
//                   Expanded(
//                     child: SingleChildScrollView(
//                       controller: scrollController,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildLocationTile(
//                               icon: Icons.circle_outlined,
//                               iconColor: AppColors.primary,
//                               title: 'PICKUP',
//                               subtitle: 'My current location',
//                               showDivider: true,
//                             ),
//                             _buildLocationTile(
//                               icon: Icons.location_on,
//                               iconColor: Colors.red,
//                               title: 'DROP-OFF',
//                               subtitle: '105 William St, Chicago, US',
//                               showDivider: false,
//                             ),
//                             const SizedBox(height: 24),
//                             const Text(
//                               'Suggested Locations',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             ..._suggestions.map((location) => Padding(
//                               padding: const EdgeInsets.only(bottom: 8.0),
//                               child: OutlinedButton(
//                                 onPressed: () {
//                                   _searchController.text = location;
//                                   // TODO: Update map location
//                                 },
//                                 style: OutlinedButton.styleFrom(
//                                   backgroundColor: Colors.grey[100],
//                                   side: BorderSide.none,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                                   alignment: Alignment.centerLeft,
//                                 ),
//                                 child: Text(
//                                   location,
//                                   style: const TextStyle(color: Colors.black87),
//                                 ),
//                               ),
//                             )).toList(),
//                             const SizedBox(height: 24),
//                             CustomButton(
//                               onPressed: () {
//                                 final location = LocationModel(
//                                   id: 'selected_${DateTime.now().millisecondsSinceEpoch}',
//                                   street: '105 William St',
//                                   city: 'Chicago',
//                                   area: 'Downtown',
//                                   state: 'IL',
//                                   country: 'US',
//                                   zipCode: '60601',
//                                   category: LocationCategory.other,
//                                   isDefault: false,
//                                   createdAt: DateTime.now().toIso8601String(),
//                                 );
//                                 widget.onLocationSelected(location);
//                                 if (mounted) Navigator.of(context).pop();
//                               },
//                               text: 'Confirm Location',
//                               backgroundColor: AppColors.primary,
//                             ),
//                             const SizedBox(height: 24),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),

//         // Non-blocking Error Banner
//         if (_errorMessage != null)
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 80,
//             left: 16,
//             right: 16,
//             child: Material(
//               color: Colors.redAccent,
//               borderRadius: BorderRadius.circular(8),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Text(
//                   _errorMessage!,
//                   style: const TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ),

//         // Loading indicator (optional overlay)
//         if (_isLoading)
//           const Center(child: CircularProgressIndicator()),
//       ],
//     ),
//   );
// }

//       // Scaffold(
//       //   body: Center(
//       //     child: Padding(
//       //       padding: const EdgeInsets.all(16.0),
//       //       child: Text(
//       //         _errorMessage!,
//       //         textAlign: TextAlign.center,
//       //         style: const TextStyle(color: Colors.red),
//       //       ),
//       //     ),
//       //   ),
//       // );
//    // }
    
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Map View
//           _buildMapView(),
          
//           // Top App Bar
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 16,
//             left: 16,
//             right: 16,
//             child: Row(
//               children: [
//                 // Back Button
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.black),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Search Bar
//                 Expanded(
//                   child: Container(
//                     height: 50,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: TextField(
//                       controller: _searchController,
//                       decoration: InputDecoration(
//                         hintText: 'Search for a location',
//                         border: InputBorder.none,
//                         suffixIcon: const Icon(Icons.search, color: Colors.grey),
//                         contentPadding: const EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           // Current Location Button
//           Positioned(
//             bottom: 200,
//             right: 16,
//             child: FloatingActionButton(
//               onPressed: () {
//                 // TODO: Center map on current location
//               },
//               backgroundColor: Colors.white,
//               child: const Icon(Icons.my_location, color: Colors.black),
//             ),
//           ),
          
//           // Bottom Sheet
//           DraggableScrollableSheet(
//             initialChildSize: 0.3,
//             minChildSize: 0.3,
//             maxChildSize: 0.6,
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       offset: const Offset(0, -2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     // Drag Handle
//                     Container(
//                       margin: const EdgeInsets.only(top: 12, bottom: 8),
//                       width: 40,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
                    
//                     Expanded(
//                       child: SingleChildScrollView(
//                         controller: scrollController,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Pickup Location
//                               _buildLocationTile(
//                                 icon: Icons.circle_outlined,
//                                 iconColor: AppColors.primary,
//                                 title: 'PICKUP',
//                                 subtitle: 'My current location',
//                                 showDivider: true,
//                               ),
                              
//                               // Drop-off Location
//                               _buildLocationTile(
//                                 icon: Icons.location_on,
//                                 iconColor: Colors.red,
//                                 title: 'DROP-OFF',
//                                 subtitle: '105 William St, Chicago, US',
//                                 showDivider: false,
//                               ),
                              
//                               const SizedBox(height: 24),
                              
//                               // Suggested Locations
//                               const Text(
//                                 'Suggested Locations',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
                              
//                               const SizedBox(height: 12),
                              
//                               // Suggested Location Buttons
//                               ..._suggestions.map((location) => Padding(
//                                 padding: const EdgeInsets.only(bottom: 8.0),
//                                 child: OutlinedButton(
//                                   onPressed: () {
//                                     _searchController.text = location;
//                                     // TODO: Update map location based on selection
//                                   },
//                                   style: OutlinedButton.styleFrom(
//                                     backgroundColor: Colors.grey[100],
//                                     side: BorderSide.none,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                                     alignment: Alignment.centerLeft,
//                                   ),
//                                   child: Text(
//                                     location,
//                                     style: const TextStyle(color: Colors.black87),
//                                   ),
//                                 ),
//                               )).toList(),
                              
//                               const SizedBox(height: 24),
                              
//                               // Confirm Button
//                               CustomButton(
//                                 onPressed: () {
//                                       // Create a location model with the selected location
//                                   final location = LocationModel(
//                                     id: 'selected_${DateTime.now().millisecondsSinceEpoch}',
//                                     street: '105 William St',
//                                     city: 'Chicago',
//                                     area: 'Downtown',
//                                     state: 'IL',
//                                     country: 'US',
//                                     zipCode: '60601',
//                                     category: LocationCategory.other,
//                                     isDefault: false,
//                                     createdAt: DateTime.now().toIso8601String(),
//                                   );
                                  
//                                   // Return the selected location
//                                   widget.onLocationSelected(location);
                                  
//                                   // Close the screen
//                                   if (mounted) {
//                                     Navigator.of(context).pop();
//                                   }
//                                 },
//                                 text: 'Confirm Location',
//                                 backgroundColor: AppColors.primary,
//                                 //style: ButtonStyle(
//                                 // backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
//                                 // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                                 // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                 //   RoundedRectangleBorder(
//                                 //     borderRadius: BorderRadius.circular(8.0),
//                                 //   ),
//                              //   ),
//                              // ),
//                               ),
                              
//                               const SizedBox(height: 24),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildLocationTile({
//     required IconData icon,
//     required Color iconColor,
//     required String title,
//     required String subtitle,
//     required bool showDivider,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: iconColor, size: 20),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         if (showDivider) ...[
//           const SizedBox(height: 16),
//           const Divider(height: 1, thickness: 1),
//           const SizedBox(height: 16),
//         ] else
//           const SizedBox(height: 12),
//       ],
//     );
//   }
// }
