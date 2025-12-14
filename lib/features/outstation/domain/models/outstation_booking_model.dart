import 'package:equatable/equatable.dart';

enum PaymentMethod { cash, qr }

class OutstationBookingModel extends Equatable {
  final String pickupLocation;
  final String destination;
  final DateTime? dateTime;
  final int numberOfPassengers;
  final double? offerRate;
  final String? comments;
  final PaymentMethod paymentMethod;
  final String? selectedOption; // For the selected category option

  const OutstationBookingModel({
    required this.pickupLocation,
    required this.destination,
    this.dateTime,
    this.numberOfPassengers = 1,
    this.offerRate,
    this.comments,
    this.paymentMethod = PaymentMethod.cash,
    this.selectedOption,
  });

  // Create a copyWith method to easily create modified copies
  OutstationBookingModel copyWith({
    String? pickupLocation,
    String? destination,
    DateTime? dateTime,
    int? numberOfPassengers,
    double? offerRate,
    String? comments,
    PaymentMethod? paymentMethod,
    String? selectedOption,
  }) {
    return OutstationBookingModel(
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destination: destination ?? this.destination,
      dateTime: dateTime ?? this.dateTime,
      numberOfPassengers: numberOfPassengers ?? this.numberOfPassengers,
      offerRate: offerRate ?? this.offerRate,
      comments: comments ?? this.comments,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }

  // Convert to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      'pickupLocation': pickupLocation,
      'destination': destination,
      'dateTime': dateTime?.toIso8601String(),
      'numberOfPassengers': numberOfPassengers,
      'offerRate': offerRate,
      'comments': comments,
      'paymentMethod': paymentMethod.toString().split('.').last,
      'selectedOption': selectedOption,
    };
  }

  // Create from JSON
  factory OutstationBookingModel.fromJson(Map<String, dynamic> json) {
    return OutstationBookingModel(
      pickupLocation: json['pickupLocation'] as String,
      destination: json['destination'] as String,
      dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
      numberOfPassengers: json['numberOfPassengers'] as int? ?? 1,
      offerRate: json['offerRate']?.toDouble(),
      comments: json['comments'] as String?,
      paymentMethod: json['paymentMethod'] == 'qr' 
          ? PaymentMethod.qr 
          : PaymentMethod.cash,
      selectedOption: json['selectedOption'] as String?,
    );
  }

  // Empty instance
  static OutstationBookingModel get empty => const OutstationBookingModel(
        pickupLocation: '',
        destination: '',
      );

  @override
  List<Object?> get props => [
        pickupLocation,
        destination,
        dateTime,
        numberOfPassengers,
        offerRate,
        comments,
        paymentMethod,
        selectedOption,
      ];

  bool get isValid => 
      pickupLocation.isNotEmpty && 
      destination.isNotEmpty &&
      dateTime != null &&
      numberOfPassengers > 0;
}
