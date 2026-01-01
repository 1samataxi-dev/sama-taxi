// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sama_taxi/features/location/domain/models/location_model.dart';
// import 'package:sama_taxi/features/location/presentation/providers/location_provider.dart';

// class AddLocationScreen extends ConsumerStatefulWidget {
//   const AddLocationScreen({super.key});

//   @override
//   ConsumerState<AddLocationScreen> createState() => _AddLocationScreenState();
// }

// class _AddLocationScreenState extends ConsumerState<AddLocationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _streetController = TextEditingController();
//   final _areaController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _zipCodeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with current values if editing
//     final location = ref.read(locationFormProvider);
//     _streetController.text = location.street;
//     _areaController.text = location.area;
//     _cityController.text = location.city;
//     _zipCodeController.text = location.zipCode ?? '';
//   }

//   final List<TextEditingController> _disposableControllers = [];

//   @override
//   void dispose() {
//     _streetController.dispose();
//     _areaController.dispose();
//     _cityController.dispose();
//     _zipCodeController.dispose();
    
//     // Dispose any additional controllers that were created
//     for (final controller in _disposableControllers) {
//       controller.dispose();
//     }
//     _disposableControllers.clear();
    
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final location = ref.watch(locationFormProvider);
//     final notifier = ref.read(locationFormProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text('Add New Location'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Select Category',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               _buildCategorySelector(notifier, location.category),
//               const SizedBox(height: 24),
//               _buildTextFormField(
//                 label: 'Street',
//                 controller: _streetController,
//                 icon: Icons.location_on,
//                 onChanged: notifier.updateStreet,
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Street is required' : null,
//               ),
//               const SizedBox(height: 16),
//               _buildDropdownField(
//                 label: 'Country',
//                 value: location.country,
//                 icon: Icons.public,
//                 items: const ['Saudi Arabia', 'UAE', 'Kuwait', 'Qatar', 'Bahrain', 'Oman'],
//                 onChanged: notifier.updateCountry,
//               ),
//               const SizedBox(height: 16),
//               _buildDropdownField(
//                 label: 'State',
//                 value: location.state,
//                 icon: Icons.public,
//                 items: const ['Riyadh', 'Jeddah', 'Dammam', 'Mecca', 'Medina'],
//                 onChanged: notifier.updateState,
//               ),
//               const SizedBox(height: 16),
//               _buildTextFormField(
//                 label: 'Area',
//                 initialValue: 'Sakakah',
//                 icon: Icons.location_pin,
//                 onChanged: notifier.updateArea,
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Area is required' : null,
//               ),
//               const SizedBox(height: 16),
//               _buildTextFormField(
//                 label: 'City',
//                 initialValue: 'حي البستان',
//                 icon: Icons.location_pin,
//                 onChanged: notifier.updateCity,
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'City is required' : null,
//               ),
//               const SizedBox(height: 16),
//               _buildTextFormField(
//                 label: 'Zip',
//                 controller: _zipCodeController,
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) => notifier.updateZipCode(value), icon: Icons.location_on,
//               ),
//               const SizedBox(height: 32),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: notifier.isValid
//                       ? () async {
//                           if (_formKey.currentState?.validate() ?? false) {
//                             try {
//                               await notifier.saveLocation();
//                               if (mounted) {
//                                 Navigator.of(context).pop();
//                               }
//                             } catch (e) {
//                               if (mounted) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text(e.toString())),
//                                 );
//                               }
//                             }
//                           }
//                         }
//                       : null,
//                   child: const Text('Add Location'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategorySelector(
//       LocationFormNotifier notifier, LocationCategory selectedCategory) {
//     return Row(
//       children: LocationCategory.values.map((category) {
//         final isSelected = category == selectedCategory;
//         return Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: isSelected
//                     ? Theme.of(context).primaryColor.withOpacity(0.1)
//                     : null,
//                 side: BorderSide(
//                   color: isSelected
//                       ? Theme.of(context).primaryColor
//                       : Colors.grey.shade300,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () => notifier.updateCategory(category),
//               child: Text(
//                 category.toString().split('.').last.toUpperCase(),
//                 style: TextStyle(
//                   color: isSelected
//                       ? Theme.of(context).primaryColor
//                       : Colors.black87,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildTextFormField({
//     required String label,
//     TextEditingController? controller,
//     required IconData icon,
//     String? initialValue,
//     TextInputType? keyboardType,
//     required Function(String) onChanged,
//     String? Function(String?)? validator,
//   }) {
//     // If initialValue is provided but controller is null, create a new controller with the initial value
//     final effectiveController = controller;
    
//     // If we created a new controller, dispose it when the widget is disposed
//     if (effectiveController != null && !_disposableControllers.contains(effectiveController)) {
//       _disposableControllers.add(effectiveController);
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//         ),
//         const SizedBox(height: 8),
//         effectiveController != null
//             ? TextFormField(
//                 controller: effectiveController,
//                 keyboardType: keyboardType,
//                 onChanged: onChanged,
//                 validator: validator,
//                 decoration: InputDecoration(
//                   labelText: label,
//                   prefixIcon: Icon(icon, color: Colors.grey[600]),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: Colors.grey[300]!),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: Colors.grey[300]!),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: Theme.of(context).primaryColor,
//                       width: 2,
//                     ),
//                   ),
//                 ),
//               )
//             : TextFormField(
//                 initialValue: initialValue,
//                 keyboardType: keyboardType,
//                 onChanged: onChanged,
//                 validator: validator,
//                 decoration: InputDecoration(
//                   labelText: label,
//                   prefixIcon: Icon(icon, color: Colors.grey[600]),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: Colors.grey[300]!),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: Colors.grey[300]!),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: Theme.of(context).primaryColor,
//                       width: 2,
//                     ),
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }

//   Widget _buildDropdownField<T>({
//     required String label,
//     required T? value,
//     required IconData icon,
//     required List<T> items,
//     required Function(T?) onChanged,
//   }) {
//     return DropdownButtonFormField<T>(
//       value: value,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.grey[600]),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: Theme.of(context).primaryColor,
//             width: 2,
//           ),
//         ),
//       ),
//       items: items.map<DropdownMenuItem<T>>((T value) {
//         return DropdownMenuItem<T>(
//           value: value,
//           child: Text(value.toString()),
//         );
//       }).toList(),
//       onChanged: onChanged,
//       isExpanded: true,
//       icon: const Icon(Icons.arrow_drop_down),
//     );
//   }
// }
