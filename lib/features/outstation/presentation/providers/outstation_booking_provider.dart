import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/features/outstation/domain/models/outstation_booking_model.dart';

// Provider for the outstation booking form state
final outstationBookingProvider = StateNotifierProvider.autoDispose<OutstationBookingNotifier, OutstationBookingModel>(
  (ref) => OutstationBookingNotifier(),
);

class OutstationBookingNotifier extends StateNotifier<OutstationBookingModel> {
  OutstationBookingNotifier()
      : super(OutstationBookingModel.empty);

  // Update pickup location
  void updatePickupLocation(String pickupLocation) {
    state = state.copyWith(pickupLocation: pickupLocation);
  }

  // Update destination
  void updateDestination(String destination) {
    state = state.copyWith(destination: destination);
  }

  // Update date and time
  void updateDateTime(DateTime dateTime) {
    state = state.copyWith(dateTime: dateTime);
  }

  // Update number of passengers
  void updateNumberOfPassengers(int numberOfPassengers) {
    state = state.copyWith(numberOfPassengers: numberOfPassengers);
  }

  // Update offer rate
  void updateOfferRate(double? offerRate) {
    state = state.copyWith(offerRate: offerRate);
  }

  // Update comments
  void updateComments(String? comments) {
    state = state.copyWith(comments: comments);
  }

  // Update payment method
  void updatePaymentMethod(PaymentMethod paymentMethod) {
    state = state.copyWith(paymentMethod: paymentMethod);
  }

  // Update selected option (category)
  void updateSelectedOption(String? selectedOption) {
    state = state.copyWith(selectedOption: selectedOption);
  }

  // Submit the booking
  Future<void> submitBooking() async {
    if (!state.isValid) {
      throw Exception('Please fill in all required fields');
    }
    
    // Here you would typically make an API call to submit the booking
    // For example:
    // try {
    //   await _bookingRepository.createBooking(state);
    // } catch (e) {
    //   rethrow;
    // }
  }

  // Reset the form
  void reset() {
    state = OutstationBookingModel.empty;
  }
}
