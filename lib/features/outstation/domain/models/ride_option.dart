import 'package:flutter/material.dart';

class RideOption {
  final String title;
  final IconData icon;
  final String id;
  
  RideOption({
    required this.title,
    required this.icon,
    String? id,
  }) : id = id ?? title.toLowerCase().replaceAll(' ', '_');

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'icon': icon.codePoint,
    };
  }

  // Create from Map
  factory RideOption.fromMap(Map<String, dynamic> map) {
    return RideOption(
      title: map['title'] as String,
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
    );
  }

  // Copy with method for immutability
  RideOption copyWith({
    String? title,
    IconData? icon,
  }) {
    return RideOption(
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }

  // Override toString for better debugging
  @override
  String toString() => 'RideOption(title: $title, icon: $icon)';

  // Override equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is RideOption &&
        other.title == title &&
        other.icon.codePoint == icon.codePoint;
  }

  @override
  int get hashCode => title.hashCode ^ icon.hashCode;
}

// List of default ride options
final localRideOptions = [
  RideOption(
    title: 'Shared Ride',
    icon: Icons.directions_car,
  ),
  RideOption(
    title: 'Parcel',
    icon: Icons.inventory_2,
  ),
  RideOption(
    title: 'Freight',
    icon: Icons.local_shipping,
  ),
];
