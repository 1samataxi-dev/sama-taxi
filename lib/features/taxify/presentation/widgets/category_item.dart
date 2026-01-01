import 'package:flutter/material.dart';
import 'package:sama_taxi/features/outstation/presentation/screens/outstation_booking_screen.dart';
import 'package:sama_taxi/features/taxify/domain/entities/category.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/_out_station_category_details.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/location_search_screen.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {

          // Navigate to the category details screen
          // Navigator.pushNamed(context, category.routeName);
              Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LocationSearchScreen()));
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),

          height: 120,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Category Image
              Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    // TODO: Replace with actual asset image
                     image: AssetImage(category.imageAsset),
                    fit: BoxFit.cover, 
                  ),
                ),
                // Placeholder icon - replace with actual image
               // child: const Icon(Icons.directions_car, size: 40, color: Colors.blue),
              ),
              const SizedBox(width: 16),
              // Category Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow icon
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
