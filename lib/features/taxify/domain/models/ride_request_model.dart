import 'package:equatable/equatable.dart';

class RideRequest extends Equatable {
  final String id;
  final String driverName;
  final String carModel;
  final double rating;
  final int ratingCount;
  final double price;
  final Duration estimatedTime;
  final double distance; // in kilometers
  final String? driverImageUrl;
  //final DateTime requestTime;

   RideRequest({
    required this.id,
    required this.driverName,
    required this.carModel,
    required this.rating,
    required this.ratingCount,
    required this.price,
    required this.estimatedTime,
    required this.distance,
   required this.driverImageUrl,
   //required this requestTime,
  }) ;

  // Factory constructor for creating from JSON
  factory RideRequest.fromJson(Map<String, dynamic> json) {
    return RideRequest(
      id: json['id'] as String,
      driverName: json['driverName'] as String,
      carModel: json['carModel'] as String,
      rating: (json['rating'] as num).toDouble(),
      ratingCount: json['ratingCount'] as int,
      price: (json['price'] as num).toDouble(),
      estimatedTime: Duration(minutes: json['estimatedTimeMinutes'] as int),
      distance: (json['distance'] as num).toDouble(),
      driverImageUrl: json['driverImageUrl'] as String?,
      // requestTime: json['requestTime'] != null 
      //     ? DateTime.parse(json['requestTime'] as String)
      //     : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverName': driverName,
      'carModel': carModel,
      'rating': rating,
      'ratingCount': ratingCount,
      'price': price,
      'estimatedTimeMinutes': estimatedTime.inMinutes,
      'distance': distance,
      'driverImageUrl': driverImageUrl,
    //  'requestTime': requestTime.toIso8601String(),
    };
  }

  // Helper getters for formatted strings
  String get formattedRating => '$rating($ratingCount)';
  String get formattedPrice => '\$${price.toStringAsFixed(0)}';
  String get formattedTime {
    if (estimatedTime.inHours > 0) {
      return '${estimatedTime.inHours}h ${estimatedTime.inMinutes.remainder(60)}min';
    }
    return '${estimatedTime.inMinutes} min';
  }
  
  String get formattedDistance => '${distance.toStringAsFixed(1)} km';

  // Copy with method for immutability
  RideRequest copyWith({
    String? id,
    String? driverName,
    String? carModel,
    double? rating,
    int? ratingCount,
    double? price,
    Duration? estimatedTime,
    double? distance,
    String? driverImageUrl,
    //DateTime? requestTime,
  }) {
    return RideRequest(
      id: id ?? this.id,
      driverName: driverName ?? this.driverName,
      carModel: carModel ?? this.carModel,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      price: price ?? this.price,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      distance: distance ?? this.distance,
      driverImageUrl: driverImageUrl ?? this.driverImageUrl,
     // requestTime: requestTime ?? this.requestTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        driverName,
        carModel,
        rating,
        ratingCount,
        price,
        estimatedTime,
        distance,
        driverImageUrl,
       // requestTime,
      ];

  // Example data for testing/demo
  //  List<RideRequest>  sampleRequests = [
  //        RideRequest(
  //         id: '1',
  //         driverName: 'Jonathan Higgins',
  //         carModel: 'Tesla Model 3',
  //         rating: 4.8,
  //         ratingCount: 127,
  //         price: 266,
  //         estimatedTime: Duration(minutes: 6),
  //         distance: 2.0, driverImageUrl: '',
  //       ),
  //        RideRequest(
  //         driverImageUrl: '',
  //         id: '2',
  //         driverName: 'Sarah Johnson',
  //         carModel: 'Toyota Camry',
  //         rating: 4.9,
  //         ratingCount: 89,
  //         price: 189,
  //         estimatedTime: Duration(minutes: 8),
  //         distance: 3.0,
  //       ),
  //     ];
}
