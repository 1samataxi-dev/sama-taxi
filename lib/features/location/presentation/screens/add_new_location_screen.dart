import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/location_model.dart';
import '../providers/location_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/location_model.dart';
import '../providers/location_provider.dart';

class AddNewLocationScreen extends ConsumerStatefulWidget {
  const AddNewLocationScreen({super.key});

  @override
  ConsumerState<AddNewLocationScreen> createState() => _AddNewLocationScreenState();
}

class _AddNewLocationScreenState extends ConsumerState<AddNewLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _streetController;
  late final TextEditingController _countryController;
  late final TextEditingController _stateController;
  late final TextEditingController _areaController;
  late final TextEditingController _cityController;
  late final TextEditingController _zipController;
  late final LocationFormNotifier locationNotifier;
  late LocationModel location;

  @override
  void initState() {
    super.initState();
    locationNotifier = ref.read(locationFormProvider.notifier);
    location = ref.read(locationFormProvider);
    
    _streetController = TextEditingController(text: 'WRJB4632, 4632, حي البستان, 7206');
    _countryController = TextEditingController(text: location.country ?? '');
    _stateController = TextEditingController(text: location.state ?? '');
    _areaController = TextEditingController(text: 'Sakakah');
    _cityController = TextEditingController(text: 'حي البستان');
    _zipController = TextEditingController(text: location.zipCode ?? '');
  }

  @override
  void dispose() {
    _streetController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  // ... rest of your existing code (keep all other methods the same) ...

  // Update the method name to match what's being called in build()
  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    IconData? icon,
    IconData? suffixIcon,
    bool readOnly = false,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: readOnly ? Colors.grey[600] : Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            prefixIcon: icon != null
                ? Icon(icon, color: Colors.grey[600], size: 20)
                : null,
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.grey[600])
                : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue[300]!),
            ),
            filled: true,
            fillColor: readOnly ? Colors.grey[100] : Colors.white,
          ),
        ),
      ],
    );
  }

  Future<void> _onAddLocation() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Update the location state with the form values
        locationNotifier.updateStreet(_streetController.text);
        locationNotifier.updateCountry(_countryController.text);
        locationNotifier.updateState(_stateController.text);
        locationNotifier.updateArea(_areaController.text);
        locationNotifier.updateCity(_cityController.text);
        locationNotifier.updateZipCode(_zipController.text);

        // Save the location
        await locationNotifier.saveLocation();
        
        // Navigate back after successful save
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
  final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add New Location',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Category',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              _buildCategorySelector(),
              const SizedBox(height: 24),
              _buildTextFormField(
                label: 'Street',
                controller: _streetController,
                icon: Icons.location_on_outlined,
                onChanged: locationNotifier.updateStreet,
                readOnly: true,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                label: 'Country',
                controller: _countryController,
                hintText: 'Country',
                icon: Icons.public,
                onChanged: locationNotifier.updateCountry,
                suffixIcon: Icons.arrow_drop_down,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                label: 'State',
                controller: _stateController,
                hintText: 'State',
                icon: Icons.public,
                onChanged: locationNotifier.updateState,
                suffixIcon: Icons.arrow_drop_down,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                label: 'Area',
                controller: _areaController,
                icon: Icons.location_on_outlined,
                onChanged: locationNotifier.updateArea,
                readOnly: true,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                label: 'City',
                controller: _cityController,
                icon: Icons.location_on_outlined,
                onChanged: locationNotifier.updateCity,
                readOnly: true,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                label: 'Zip',
                controller: _zipController,
                keyboardType: TextInputType.number,
                onChanged: locationNotifier.updateZipCode,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _onAddLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Add Location',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String selectedCategory = 'Home'; // Add this line at the top of your state class

  Widget _buildCategorySelector() {
    final categories = ['Home','Work','Other'];
    //   {'name': 'Home', 'value': LocationCategory.home},
    //   {'name': 'Work', 'value': LocationCategory.work},
    //   {'name': 'Other', 'value': LocationCategory.other},
    // ];
    
    return Row(
      children: List.generate(categories.length, (index) {
      final isSelected = selectedCategory == categories[index];
        return Expanded(
          child: GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFF5F5F5) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Colors.grey[300]! : Colors.grey[200]!,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getCategoryIcon(categories[index]),
                    color: isSelected ? Colors.blue : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                   categories[index],
                    style: GoogleFonts.poppins(
                      color: isSelected ? Colors.black87 : Colors.grey[600],
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
              onTap: () {
            setState(() {
              selectedCategory = categories[index];
            });
          },
          ),
        
        );
      })
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Home':
        return Icons.home_outlined;
      case 'Work':
        return Icons.work_outline;
      case 'Other':
        return Icons.location_on_outlined;
      default:
        return Icons.help_outline;
    }
  
  }

}
