// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class OutstationBookingScreen extends StatefulWidget {
//   const OutstationBookingScreen({Key? key}) : super(key: key);

//   @override
//   _OutstationBookingScreenState createState() => _OutstationBookingScreenState();
// }

// class _OutstationBookingScreenState extends State<OutstationBookingScreen> {
//   final TextEditingController _pickupController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _passengerController = TextEditingController();
//   final TextEditingController _offerRateController = TextEditingController();
//   final TextEditingController _commentsController = TextEditingController();

//   String? _selectedOption;
//   final List<Map<String, dynamic>> _options = [
//     {'title': 'Shared Ride', 'icon': Icons.directions_car},
//     {'title': 'Parcel', 'icon': Icons.inventory_2},
//     {'title': 'Freight', 'icon': Icons.local_shipping},
//   ];

//   @override
//   void dispose() {
//     _pickupController.dispose();
//     _destinationController.dispose();
//     _dateController.dispose();
//     _passengerController.dispose();
//     _offerRateController.dispose();
//     _commentsController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text(
//           'Out Station',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildLocationInputs(),
//             const SizedBox(height: 8),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(
//                 'Fares Don\'t Include Tolls',
//                 style: TextStyle(color: Colors.red, fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildOptionsSection(),
//             const SizedBox(height: 16),
//             _buildDateTimeField(),
//             const SizedBox(height: 16),
//             _buildPassengerField(),
//             const SizedBox(height: 16),
//             _buildOfferRateField(),
//             const SizedBox(height: 16),
//             _buildCommentsField(),
//             const SizedBox(height: 24),
//             _buildBookNowButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationInputs() {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _pickupController,
//               decoration: InputDecoration(
//                 hintText: 'Pickup Location',
//                 border: InputBorder.none,
//                 prefixIcon: const Icon(Icons.location_on, color: Colors.green),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.add_location_alt, color: Colors.blue),
//                   onPressed: () {
//                     // Handle add location
//                   },
//                 ),
//               ),
//             ),
//             const Divider(height: 1, thickness: 1),
//             TextFormField(
//               controller: _destinationController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter Destination',
//                 border: InputBorder.none,
//                 prefixIcon: Icon(Icons.location_on, color: Colors.red),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOptionsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
//           child: Text(
//             'Select Option',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: _options.map((option) {
//             final isSelected = _selectedOption == option['title'];
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedOption = option['title'] as String;
//                 });
//               },
//               child: Container(
//                 width: 100,
//                 padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: isSelected ? Colors.blue : Colors.grey.shade300,
//                     width: 1.5,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Icon(
//                       option['icon'] as IconData,
//                       color: isSelected ? Colors.blue : Colors.grey,
//                       size: 32,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       option['title'] as String,
//                       style: TextStyle(
//                         color: isSelected ? Colors.blue : Colors.black87,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const Icon(Icons.info_outline, size: 16, color: Colors.grey),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateTimeField() {
//     return TextFormField(
//       controller: _dateController,
//       readOnly: true,
//       onTap: () async {
//         final DateTime? picked = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime.now(),
//           lastDate: DateTime(2101),
//         );
//         if (picked != null) {
//           final TimeOfDay? time = await showTimePicker(
//             context: context,
//             initialTime: TimeOfDay.now(),
//           );
//           if (time != null) {
//             setState(() {
//               _dateController.text =
//                   '${picked.day}/${picked.month}/${picked.year} at ${time.hour}:${time.minute}';
//             });
//           }
//         }
//       },
//       decoration: InputDecoration(
//         hintText: 'Date And Time',
//         prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
//         suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//       ),
//     );
//   }

//   Widget _buildPassengerField() {
//     return TextFormField(
//       controller: _passengerController,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         hintText: 'Number Of Passenger',
//         prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
//         suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//       ),
//     );
//   }

//   Widget _buildOfferRateField() {
//     return TextFormField(
//       controller: _offerRateController,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         hintText: 'Enter Your Offer Rate',
//         labelText: 'Enter Fare Amount',
//         prefix: const Text('\$ '),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//       ),
//     );
//   }

//   Widget _buildCommentsField() {
//     return TextFormField(
//       controller: _commentsController,
//       maxLines: 3,
//       decoration: InputDecoration(
//         hintText: 'Comments',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//       ),
//     );
//   }

//   Widget _buildBookNowButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           // Handle book now
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: const Text(
//           'Book Now',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
