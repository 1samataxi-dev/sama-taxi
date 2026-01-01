import 'package:flutter/material.dart';
import 'package:sama_taxi/core/constants/app_colors.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/vehicle_selection_screen.dart';

class LocationSearchScreen extends StatefulWidget {
  final bool isPickup;
  
  const LocationSearchScreen({
    Key? key,
    this.isPickup = true,
  }) : super(key: key);

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _recentLocations = [
    {
      'name': 'Koramangala',
      'address': 'Koramangala, Bengaluru, Karnataka, India',
    },
    {
      'name': 'Purdys Chocolatier',
      'address': '123 Yonge St, Toronto, ON M5C 2W2, Canada',
    },
    {
      'name': 'Toronto Eaton Centre',
      'address': '220 Yonge St, Toronto, ON M5B 2H1, Canada',
    },
    {
      'name': 'Toronto PATH',
      'address': '1 King St W, Toronto, ON M5H 1A1, Canada',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set location',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a location',
                  prefixIcon: Icon(Icons.search, color: AppColors.neutral500),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: AppColors.neutral500),
                          onPressed: () => _searchController.clear(),
                        )
                      : null,
                  filled: true,
                  fillColor: theme.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                style: textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),

            // Location Type Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildLocationTypeButton(
                      icon: Icons.home_outlined,
                      label: 'Home',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildLocationTypeButton(
                      icon: Icons.work_outline,
                      label: 'Work',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            
            // Recent Locations List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _recentLocations.length,
                itemBuilder: (context, index) {
                  final location = _recentLocations[index];
                  return _buildLocationTile(
                    icon: Icons.history,
                    title: location['name']!,
                    subtitle: location['address']!,
                    onTap: () {
                      // Handle location selection
                      Navigator.pop(context, location);
                    },
                  );
                },
              ),
            ),

            // Done Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                 Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const VehicleSelectionScreen(),
  ),
);


                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neutral900,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTypeButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.neutral100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Add $label',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.neutral800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.neutral100,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.neutral600, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.neutral900,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.neutral500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
