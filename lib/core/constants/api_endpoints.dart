class ApiEndpoints {
  // Base URL - Update this based on your environment
  static const String baseUrl = 'https://samataxi.net/paneldb/';

  // API Version
  static const String apiVersion = '$baseUrl/paneldb/';

  // Full base URL with version
  //static const String fullBaseUrl = '$baseUrl';

  // Authentication Endpoints
  static const String login = 'users/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String logoutAll = '/logout-all';
  static const String refreshToken = '/refresh';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';
  static const String resendVerification = '/resend-verification';

  // User Profile Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String changePassword = '/user/change-password';
  static const String uploadAvatar = '/user/avatar';
  static const String deleteAccount = '/user/delete-account';

  // Hotels Endpoints
  static const String hotels = '/hotels';
  static const String hotelDetails = '/hotels/{id}';
  static const String hotelSearch = '/hotels/search';
  static const String hotelsByDestination = '/hotels/destination/{destination}';
  static const String hotelAvailability = '/hotels/{id}/availability';
  static const String hotelReviews = '/hotels/{id}/reviews';
  static const String hotelAmenities = '/hotels/{id}/amenities';

  // Packages Endpoints
  static const String packages = '/packages';
  static const String packageDetails = '/packages/{id}';
  static const String packageSearch = '/packages/search';
  static const String packagesByDestination =
      '/packages/destination/{destination}';
  static const String packageItinerary = '/packages/{id}/itinerary';
  static const String packageInclusions = '/packages/{id}/inclusions';
  static const String popularPackages = '/packages/popular';
  static const String featuredPackages = '/packages/featured';

  // Tours Endpoints
  static const String tours = '/tours';
  static const String tourDetails = '/tours/{id}';
  static const String tourSearch = '/tours/search';
  static const String toursByDestination = '/tours/destination/{destination}';
  static const String tourSchedule = '/tours/{id}/schedule';
  static const String tourGuides = '/tours/{id}/guides';
  static const String tourReviews = '/tours/{id}/reviews';
  static const String upcomingTours = '/tours/upcoming';

  // Visits/Attractions Endpoints
  static const String visits = '/visits';
  static const String visitDetails = '/visits/{id}';
  static const String visitSearch = '/visits/search';
  static const String visitsByDestination = '/visits/destination/{destination}';
  static const String visitAvailability = '/visits/{id}/availability';
  static const String visitTickets = '/visits/{id}/tickets';
  static const String popularVisits = '/visits/popular';
  static const String nearbyVisits = '/visits/nearby';

  // Offers /Attractions Endpoints
  static const String offers = '/offers';
  static const String offerDetails = '/offers/{id}';
  
  // categories/Attractions Endpoints
  static const String categories = '/categories';
  static const String categoryDetails = '/categories/{id}';
 

  // Bookings Endpoints
  static const String bookings = '/bookings';
  static const String bookingDetails = '/bookings/{id}';
  static const String createBooking = '/bookings';
  static const String cancelBooking = '/bookings/{id}/cancel';
  static const String updateBooking = '/bookings/{id}';
  static const String bookingHistory = '/bookings/history';
  static const String upcomingBookings = '/bookings/upcoming';

  // Hotel Bookings
  static const String hotelBookings = '/bookings/hotels';
  static const String createHotelBooking = '/bookings/hotels';
  static const String hotelBookingDetails = '/bookings/hotels/{id}';
  static const String cancelHotelBooking = '/bookings/hotels/{id}/cancel';

  // Package Bookings
  static const String packageBookings = '/bookings/packages';
  static const String createPackageBooking = '/bookings/packages';
  static const String packageBookingDetails = '/bookings/packages/{id}';
  static const String cancelPackageBooking = '/bookings/packages/{id}/cancel';

  // Tour Bookings
  static const String tourBookings = '/bookings/tours';
  static const String createTourBooking = '/bookings/tours';
  static const String tourBookingDetails = '/bookings/tours/{id}';
  static const String cancelTourBooking = '/bookings/tours/{id}/cancel';

  // Visit Bookings
  static const String visitBookings = '/bookings/visits';
  static const String createVisitBooking = '/bookings/visits';
  static const String visitBookingDetails = '/bookings/visits/{id}';
  static const String cancelVisitBooking = '/bookings/visits/{id}/cancel';

  // Destinations Endpoints
  static const String destinations = '/destinations';
  static const String destinationDetails = '/destinations/{id}';
  static const String destinationSearch = '/destinations/search';
  static const String popularDestinations = '/destinations/popular';
  static const String destinationWeather = '/destinations/{id}/weather';
  static const String destinationAttractions = '/destinations/{id}/attractions';
  static const String destinationHotels = '/destinations/{id}/hotels';
  static const String destinationTours = '/destinations/{id}/tours';

  // Search Endpoints
  static const String globalSearch = '/search';
  static const String searchSuggestions = '/search/suggestions';
  static const String searchHistory = '/search/history';
  static const String clearSearchHistory = '/search/history/clear';

  // Favorites Endpoints
  static const String favorites = '/favorites';
  static const String addToFavorites = '/favorites';
  static const String removeFromFavorites = '/favorites/{id}';
  static const String favoriteHotels = '/favorites/hotels';
  static const String favoritePackages = '/favorites/packages';
  static const String favoriteTours = '/favorites/tours';
  static const String favoriteVisits = '/favorites/visits';

  // Reviews Endpoints
  static const String reviews = '/reviews';
  static const String createReview = '/reviews';
  static const String updateReview = '/reviews/{id}';
  static const String deleteReview = '/reviews/{id}';
  static const String userReviews = '/reviews/user';
  static const String reviewsByEntity = '/reviews/{entityType}/{entityId}';

  // Notifications Endpoints
  static const String notifications = '/notifications';
  static const String markNotificationRead = '/notifications/{id}/read';
  static const String markAllNotificationsRead = '/notifications/read-all';
  static const String deleteNotification = '/notifications/{id}';
  static const String notificationSettings = '/notifications/settings';
  static const String updateNotificationSettings = '/notifications/settings';

  // Payment Endpoints
  static const String payments = '/payments';
  static const String createPayment = '/payments';
  static const String paymentMethods = '/payments/methods';
  static const String addPaymentMethod = '/payments/methods';
  static const String removePaymentMethod = '/payments/methods/{id}';
  static const String paymentHistory = '/payments/history';
  static const String refundPayment = '/payments/{id}/refund';

  // Analytics Endpoints
  static const String analytics = '/analytics';
  static const String userActivity = '/analytics/user-activity';
  static const String popularSearches = '/analytics/popular-searches';
  static const String trendingDestinations = '/analytics/trending-destinations';

  // Settings Endpoints
  static const String appSettings = '/settings';
  static const String updateSettings = '/settings';
  static const String currencies = '/settings/currencies';
  static const String languages = '/settings/languages';
  static const String countries = '/settings/countries';

  // File Upload Endpoints
  static const String uploadImage = '/upload/image';
  static const String uploadDocument = '/upload/document';
  static const String deleteFile = '/upload/{id}';

  // Utility Methods

  /// Replace path parameters in endpoint URLs
  /// Example: replacePathParams('/hotels/{id}', {'id': '123'}) returns '/hotels/123'
  static String replacePathParams(
    String endpoint,
    Map<String, dynamic> params,
  ) {
    var result = endpoint;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    return result;
  }

  /// Get full URL with base URL
  static String getFullUrl(String endpoint) => endpoint;

  /// Get URL with path parameters replaced
  static String getUrlWithParams(String endpoint, Map<String, dynamic> params) {
    final replacedEndpoint = replacePathParams(endpoint, params);
    return getFullUrl(replacedEndpoint);
  }

  // Environment-specific configurations
  static const Map<String, String> environments = {
    'development': 'https://samataxi.net/paneldb/',
    'staging': 'https://samataxi.net/paneldb/',
    'production': 'https://samataxi.net/paneldb/',
  };

  /// Get base URL for specific environment
  static String getBaseUrlForEnvironment(String environment) => environments[environment] ?? environments['production']!;

  // API Response Status Codes
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusNoContent = 204;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusConflict = 409;
  static const int statusUnprocessableEntity = 422;
  static const int statusInternalServerError = 500;
  static const int statusServiceUnavailable = 503;

  // Request Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAuthorization = 'Authorization';
  static const String headerAccept = 'Accept';
  static const String headerUserAgent = 'User-Agent';
  static const String headerAcceptLanguage = 'Accept-Language';

  // Content Types
  static const String contentTypeJson = 'application/json';
  static const String contentTypeFormData = 'multipart/form-data';
  static const String contentTypeUrlEncoded =
      'application/x-www-form-urlencoded';
}
