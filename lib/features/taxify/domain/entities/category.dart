class CategoryModel {
  final String id;
  final String title;
  final String description;
  final String imageAsset;
  final String routeName;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.routeName,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
  return CategoryModel(
    id: json['id']?.toString() ?? '',
    title: json['title']?.toString() ?? '',
    description: json['description']?.toString() ?? '',
    imageAsset: json['imageAsset']?.toString() ?? '',
    routeName: json['routeName']?.toString() ?? '',
  );
}
  

  
}
List<CategoryModel>  localcategories = [
        CategoryModel(
          id: '1',
          title: 'Ride',
          description: 'Book a ride to your destination',
          imageAsset: 'assets/images/white-cars.png',
          routeName: 'Ride',
        ),
        CategoryModel(
          id: '2',
          title: 'Outstation',
          description: 'Plan an outstation trip',
          imageAsset: 'assets/images/outstation.jpg',
          routeName: 'Outstation',
        ),
        CategoryModel(
          id: '3',
          title: 'Rental',
          description: 'Rent a vehicle for hours',
          imageAsset: 'assets/images/rental.jpeg',
          routeName: 'Rental',
        ),
      ];