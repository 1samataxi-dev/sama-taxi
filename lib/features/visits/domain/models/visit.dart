import 'package:sama_taxi/core/data/safe_json.dart';

class Visit {

  Visit({
    required this.id,
    required this.type,
    required this.fromDestination,
    required this.toDestination,
    this.description,
    this.destination,
    required this.pricePerPerson,
    required this.visitDate,
    required this.availableSeats,
    this.images,
    this.featuredImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
      id: SafeJsonData.intSafe(json['id']),
      type: json['type'] ?? '',
      fromDestination: json['from_destination'] ?? '',
      toDestination: json['to_destination'] ?? '',
      description: json['description'] ?? '',
      destination: json['destination'] ?? '',
      pricePerPerson: SafeJsonData.doubleSafe(json['price_per_person']),
      visitDate: DateTime.parse(json['visit_date'] ?? ''),
      availableSeats: json['available_seats'] ?? 0,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : null,
      featuredImage: json['featured_image'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] ?? '')
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] ?? '')
          : null,
    );
  final int id;
  final String type;
  final String fromDestination;
  final String toDestination;
  final String? description;
  final String? destination;
  final double pricePerPerson;
  final DateTime visitDate;
  final int availableSeats;
  final List<String>? images;
  final String? featuredImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
      'id': id,
      'type': type,
      'from_destination': fromDestination,
      'to_destination': toDestination,
      if (description != null) 'description': description,
      if (destination != null) 'destination': destination,
      'price_per_person': pricePerPerson,
      'visit_date': visitDate.toIso8601String().split('T')[0],
      'available_seats': availableSeats,
      if (images != null) 'images': images,
      if (featuredImage != null) 'featured_image': featuredImage,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
}
