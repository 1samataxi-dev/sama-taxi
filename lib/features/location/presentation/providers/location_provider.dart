import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/features/location/domain/models/location_model.dart';

final locationFormProvider = StateNotifierProvider.autoDispose<LocationFormNotifier, LocationModel>(
  (ref) => LocationFormNotifier(),
);

class LocationFormNotifier extends StateNotifier<LocationModel> {
  LocationFormNotifier() : super(LocationModel.empty);

  void updateStreet(String street) {
    state = state.copyWith(street: street);
  }

  void updateCountry(String? country) {
    state = state.copyWith(country: country);
  }

 void updateState(String? stateValue) {
  state = state.copyWith(state: stateValue);
}

  void updateArea(String area) {
    state = state.copyWith(area: area);
  }

  void updateCity(String city) {
    state = state.copyWith(city: city);
  }

  void updateZipCode(String? zipCode) {
    state = state.copyWith(zipCode: zipCode);
  }

  void updateCategory(LocationCategory category) {
    state = state.copyWith(category: category);
  }

  void setAsDefault(bool isDefault) {
    state = state.copyWith(isDefault: isDefault);
  }

  bool get isValid => 
      state.street.isNotEmpty && 
      state.area.isNotEmpty && 
      state.city.isNotEmpty;

  Future<void> saveLocation() async {
    if (!isValid) {
      throw Exception('Please fill in all required fields');
    }
    
    // Here you would typically save to a repository
    // For example:
    // try {
    //   await _locationRepository.saveLocation(state);
    // } catch (e) {
    //   rethrow;
    // }
  }

  void reset() {
    state = LocationModel.empty;
  }
}
