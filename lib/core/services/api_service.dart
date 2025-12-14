import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sama_taxi/core/constants/api_endpoints.dart';
import 'package:sama_taxi/core/network/dio_client.dart';

class ApiService {

  ApiService(this._dioClient);
  final DioClient _dioClient;

  // Generic GET request
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
  }) async {
    final url = pathParameters != null
        ? ApiEndpoints.replacePathParams(endpoint, pathParameters)
        : endpoint;

    return _dioClient.dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // Generic POST request
  Future<Response> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
  }) async {
    final url = pathParameters != null
        ? ApiEndpoints.replacePathParams(endpoint, pathParameters)
        : endpoint;
debugPrint("Post data to:$endpoint");
    return _dioClient.dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // Generic PUT request
  Future<Response> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
  }) async {
    final url = pathParameters != null
        ? ApiEndpoints.replacePathParams(endpoint, pathParameters)
        : endpoint;

    return _dioClient.dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // Generic PATCH request
  Future<Response> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
  }) async {
    final url = pathParameters != null
        ? ApiEndpoints.replacePathParams(endpoint, pathParameters)
        : endpoint;

    return _dioClient.dio.patch(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // Generic DELETE request
  Future<Response> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
  }) async {
    final url = pathParameters != null
        ? ApiEndpoints.replacePathParams(endpoint, pathParameters)
        : endpoint;

    return _dioClient.dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // Authentication Methods
  Future<Response> login(String email, String password) => post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );

  Future<Response> register(Map<String, dynamic> userData) => post(ApiEndpoints.register, data: userData);

  Future<Response> logout() => post(ApiEndpoints.logout);

  Future<Response> logoutAll() => post(ApiEndpoints.logoutAll);

  Future<Response> refreshToken(String refreshToken) => post(
      ApiEndpoints.refreshToken,
      data: {'refresh_token': refreshToken},
    );

  // Hotels Methods
  Future<Response> getHotels({Map<String, dynamic>? queryParams}) => get(ApiEndpoints.hotels, queryParameters: queryParams);

  Future<Response> getHotelDetails(String hotelId) => get(ApiEndpoints.hotelDetails, pathParameters: {'id': hotelId});

  Future<Response> searchHotels(Map<String, dynamic> searchParams) => get(ApiEndpoints.hotelSearch, queryParameters: searchParams);

  Future<Response> getHotelsByDestination(String destination) => get(
      ApiEndpoints.hotelsByDestination,
      pathParameters: {'destination': destination},
    );

  // Packages Methods
  Future<Response> getPackages({Map<String, dynamic>? queryParams}) => get(ApiEndpoints.packages, queryParameters: queryParams);

  Future<Response> getPackageDetails(String packageId) => get(ApiEndpoints.packageDetails, pathParameters: {'id': packageId});

  Future<Response> searchPackages(Map<String, dynamic> searchParams) => get(ApiEndpoints.packageSearch, queryParameters: searchParams);

  Future<Response> getPopularPackages() => get(ApiEndpoints.popularPackages);

  Future<Response> getFeaturedPackages() => get(ApiEndpoints.featuredPackages);

  // Tours Methods
  Future<Response> getTours({Map<String, dynamic>? queryParams}) => get(ApiEndpoints.tours, queryParameters: queryParams);

  Future<Response> getTourDetails(String tourId) => get(ApiEndpoints.tourDetails, pathParameters: {'id': tourId});

  Future<Response> searchTours(Map<String, dynamic> searchParams) => get(ApiEndpoints.tourSearch, queryParameters: searchParams);

  Future<Response> getUpcomingTours() => get(ApiEndpoints.upcomingTours);

  // Visits Methods
  Future<Response> getVisits({Map<String, dynamic>? queryParams}) => get(ApiEndpoints.visits, queryParameters: queryParams);

  Future<Response> getVisitDetails(String visitId) => get(ApiEndpoints.visitDetails, pathParameters: {'id': visitId});

  Future<Response> searchVisits(Map<String, dynamic> searchParams) => get(ApiEndpoints.visitSearch, queryParameters: searchParams);

  Future<Response> getPopularVisits() => get(ApiEndpoints.popularVisits);

  Future<Response> getNearbyVisits(double lat, double lng) => get(
      ApiEndpoints.nearbyVisits,
      queryParameters: {'lat': lat, 'lng': lng},
    );

  // Bookings Methods
  Future<Response> getBookings({Map<String, dynamic>? queryParams}) => get(ApiEndpoints.bookings, queryParameters: queryParams);

  Future<Response> getBookingDetails(String bookingId) => get(ApiEndpoints.bookingDetails, pathParameters: {'id': bookingId});

  Future<Response> createBooking(Map<String, dynamic> bookingData) => post(ApiEndpoints.createBooking, data: bookingData);

  Future<Response> cancelBooking(String bookingId) => post(ApiEndpoints.cancelBooking, pathParameters: {'id': bookingId});

  Future<Response> getBookingHistory() => get(ApiEndpoints.bookingHistory);

  Future<Response> getUpcomingBookings() => get(ApiEndpoints.upcomingBookings);

  // Hotel Bookings
  Future<Response> getHotelBookings() => get(ApiEndpoints.hotelBookings);

  Future<Response> createHotelBooking(Map<String, dynamic> bookingData) => post(ApiEndpoints.createHotelBooking, data: bookingData);

  Future<Response> cancelHotelBooking(String bookingId) => post(
      ApiEndpoints.cancelHotelBooking,
      pathParameters: {'id': bookingId},
    );

  // Package Bookings
  Future<Response> getPackageBookings() => get(ApiEndpoints.packageBookings);

  Future<Response> createPackageBooking(Map<String, dynamic> bookingData) => post(ApiEndpoints.createPackageBooking, data: bookingData);

  Future<Response> cancelPackageBooking(String bookingId) => post(
      ApiEndpoints.cancelPackageBooking,
      pathParameters: {'id': bookingId},
    );

  // Tour Bookings
  Future<Response> getTourBookings() => get(ApiEndpoints.tourBookings);

  Future<Response> createTourBooking(Map<String, dynamic> bookingData) => post(ApiEndpoints.createTourBooking, data: bookingData);

  Future<Response> cancelTourBooking(String bookingId) => post(
      ApiEndpoints.cancelTourBooking,
      pathParameters: {'id': bookingId},
    );

  // Visit Bookings
  Future<Response> getVisitBookings() => get(ApiEndpoints.visitBookings);

  Future<Response> createVisitBooking(Map<String, dynamic> bookingData) => post(ApiEndpoints.createVisitBooking, data: bookingData);

  Future<Response> cancelVisitBooking(String bookingId) => post(
      ApiEndpoints.cancelVisitBooking,
      pathParameters: {'id': bookingId},
    );

  // Destinations Methods
  Future<Response> getDestinations() => get(ApiEndpoints.destinations);

  Future<Response> getDestinationDetails(String destinationId) => get(
      ApiEndpoints.destinationDetails,
      pathParameters: {'id': destinationId},
    );

  Future<Response> searchDestinations(String query) => get(ApiEndpoints.destinationSearch, queryParameters: {'q': query});

  Future<Response> getPopularDestinations() => get(ApiEndpoints.popularDestinations);

  // Search Methods
  Future<Response> globalSearch(String query) => get(ApiEndpoints.globalSearch, queryParameters: {'q': query});

  Future<Response> getSearchSuggestions(String query) => get(ApiEndpoints.searchSuggestions, queryParameters: {'q': query});

  Future<Response> getSearchHistory() => get(ApiEndpoints.searchHistory);

  Future<Response> clearSearchHistory() => delete(ApiEndpoints.clearSearchHistory);

  // Favorites Methods
  Future<Response> getFavorites() => get(ApiEndpoints.favorites);

  Future<Response> addToFavorites(String entityType, String entityId) => post(
      ApiEndpoints.addToFavorites,
      data: {'entity_type': entityType, 'entity_id': entityId},
    );

  Future<Response> removeFromFavorites(String favoriteId) => delete(
      ApiEndpoints.removeFromFavorites,
      pathParameters: {'id': favoriteId},
    );

  // Reviews Methods
  Future<Response> getReviews(String entityType, String entityId) => get(
      ApiEndpoints.reviewsByEntity,
      pathParameters: {'entityType': entityType, 'entityId': entityId},
    );

  Future<Response> createReview(Map<String, dynamic> reviewData) => post(ApiEndpoints.createReview, data: reviewData);

  Future<Response> updateReview(
    String reviewId,
    Map<String, dynamic> reviewData,
  ) => put(
      ApiEndpoints.updateReview,
      pathParameters: {'id': reviewId},
      data: reviewData,
    );

  Future<Response> deleteReview(String reviewId) => delete(ApiEndpoints.deleteReview, pathParameters: {'id': reviewId});

  // User Profile Methods
  Future<Response> getProfile() => get(ApiEndpoints.profile);

  Future<Response> updateProfile(Map<String, dynamic> profileData) => put(ApiEndpoints.updateProfile, data: profileData);

  Future<Response> changePassword(String currentPassword, String newPassword) => post(
      ApiEndpoints.changePassword,
      data: {'current_password': currentPassword, 'new_password': newPassword},
    );

  // File Upload Methods
  Future<Response> uploadImage(String filePath) async => post(
      ApiEndpoints.uploadImage,
      data: FormData.fromMap({'image': await MultipartFile.fromFile(filePath)}),
    );

  Future<Response> uploadDocument(String filePath) async => post(
      ApiEndpoints.uploadDocument,
      data: FormData.fromMap({
        'document': await MultipartFile.fromFile(filePath),
      }),
    );

  // Notifications Methods
  Future<Response> getNotifications() => get(ApiEndpoints.notifications);

  Future<Response> markNotificationRead(String notificationId) => post(
      ApiEndpoints.markNotificationRead,
      pathParameters: {'id': notificationId},
    );

  Future<Response> markAllNotificationsRead() => post(ApiEndpoints.markAllNotificationsRead);

  // Settings Methods
  Future<Response> getSettings() => get(ApiEndpoints.appSettings);

  Future<Response> updateSettings(Map<String, dynamic> settings) => put(ApiEndpoints.updateSettings, data: settings);

  Future<Response> getCurrencies() => get(ApiEndpoints.currencies);

  Future<Response> getLanguages() => get(ApiEndpoints.languages);

  Future<Response> getCountries() => get(ApiEndpoints.countries);
}
