import 'package:equatable/equatable.dart';
import 'package:sama_taxi/core/data/safe_json.dart';


class Offers extends Equatable {
  final double discount;
  final String driverName;
  final double rating;
  final String description;
  final String carType;
  final String capacity;
  final String validUntil;

  const Offers({
    required this.discount,
    required this.driverName,
    required this.rating,
    required this.description,
    required this.carType,
    required this.capacity,
    required this.validUntil,
  });

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
      discount: SafeJsonData.doubleSafe(json['discount']),
      driverName: json['driverName'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      carType: json['carType'] ?? '',
      capacity: json['capacity'] ?? '',
      validUntil: json['validUntil'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'discount': discount,
      'driverName': driverName,
      'rating': rating,
      'description': description,
      'carType': carType,
      'capacity': capacity,
      'validUntil': validUntil,
    };
  }

  @override
  List<Object> get props => [
        discount,
        driverName,
        rating,
        description,
        carType,
        capacity,
        validUntil,
      ];
}
// Local offers data
final List<Offers> localOffers = [
  Offers(
    discount: 10.0,
    driverName: 'Ahmed Mohamed',
    rating: 4.8,
    description: 'Special weekend discount for all rides',
    carType: 'Sedan',
    capacity: '4 passengers',
    validUntil: '2023-12-31',
  ),
  Offers(
    discount: 15.0,
    driverName: 'Omar Ali',
    rating: 4.9,
    description: 'New user discount',
    carType: 'SUV',
    capacity: '6 passengers',
    validUntil: '2023-12-25',
  ),
  Offers(
    discount: 20.0,
    driverName: 'Fatima Hassan',
    rating: 5.0,
    description: 'Holiday special discount',
    carType: 'Luxury',
    capacity: '4 passengers',
    validUntil: '2024-01-07',
  ),
];

