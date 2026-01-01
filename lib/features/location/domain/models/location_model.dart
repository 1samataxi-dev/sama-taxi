import 'package:equatable/equatable.dart';

enum LocationCategory { home, work, other }

class LocationModel extends Equatable {
  final String? id;
  final String street;
  final String? country;
  final String? state;
  final String area;
  final String city;
  final String? zipCode;
  final LocationCategory category;
  final bool isDefault;
  final String? createdAt;

  const LocationModel({
  required this.id ,
        required this.createdAt,
    required this.street,
    this.country,
    this.state,
    required this.area,
    required this.city,
    this.zipCode,
    this.category = LocationCategory.other,
    this.isDefault = false,
    
  });

  LocationModel copyWith({
    String? id ,
      String?  createdAt,
    String? street,
    String? country,
    String? state,
    String? area,
    String? city,
    String? zipCode,
    LocationCategory? category,
    bool? isDefault,
  }) {
    return LocationModel(
      id: id,
      street: street ?? this.street,
      country: country ?? this.country,
      state: state ?? this.state,
      area: area ?? this.area,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      category: category ?? this.category,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'country': country,
      'state': state,
      'area': area,
      'city': city,
      'zipCode': zipCode,
      'category': category.toString().split('.').last,
      'isDefault': isDefault,
      'createdAt': createdAt,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      street: json['street'],
      country: json['country'],
      state: json['state'],
      area: json['area'],
      city: json['city'],
      zipCode: json['zipCode'],
      category: LocationCategory.values.firstWhere(
        (e) => e.toString() == 'LocationCategory.${json['category']}',
        orElse: () => LocationCategory.other,
      ),
      isDefault: json['isDefault'] ?? false,
      createdAt: json['createdAt'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        street,
        country,
        state,
        area,
        city,
        zipCode,
        category,
        isDefault,
        createdAt,
      ];

  static LocationModel get empty => LocationModel(
        id: 'empty',
        street: '',
        area: '',
        city: '',
        createdAt: '${DateTime.now().toIso8601String()}',
      );
}
