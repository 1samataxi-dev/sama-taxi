import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/network/auth_interceptor.dart';
import 'package:sama_taxi/core/network/network_config.dart';

class DioClient {

  DioClient(Ref ref) {
    // Use the new network configuration for better platform support
    _dio = NetworkConfig.createDio(interceptors: [AuthInterceptor(ref)]);
  }
  late final Dio _dio;

  Dio get dio => _dio;

  // Auth endpoints
  //Future<Response> register(Map<String, dynamic> data) => _dio.post('/customer/register', data: data);

  Future<Response> login(Map<String, dynamic> data) => _dio.post('/users/login', data: data);

  Future<Response> logout() => _dio.post('/auth/logout');

  Future<Response> logoutAll() => _dio.post('/auth/logout-all');

  Future<Response> getMe() => _dio.get('/user/profile');

  Future<Response> getOffers() => _dio.get('/offers');

  

  // Hotels
  Future<Response> getHotels() => _dio.get('/hotels');

  // Hotel Bookings
  Future<Response> getHotelBookings() => _dio.get('/bookings/hotels');

  Future<Response> createHotelBooking(Map<String, dynamic> data) => _dio.post('/bookings/hotels', data: data);

  Future<Response> updateHotelBooking(int id, Map<String, dynamic> data) => _dio.put('/bookings/hotels/$id', data: data);

  Future<Response> deleteHotelBooking(int id) => _dio.delete('/bookings/hotels/$id');

  // Packages
  Future<Response> getPackages() => _dio.get('/packages');

  Future<Response> getPackage(int id) => _dio.get('/packages/$id');

  Future<Response> createPackage(Map<String, dynamic> data) => _dio.post('/packages', data: data);

  Future<Response> updatePackage(int id, Map<String, dynamic> data) => _dio.put('/packages/$id', data: data);

  Future<Response> deletePackage(int id) => _dio.delete('/packages/$id');

  // Package Bookings
  Future<Response> getPackageBookings() => _dio.get('/bookings/packages');

  Future<Response> getPackageBooking(int id) => _dio.get('/bookings/packages/$id');

  Future<Response> createPackageBooking(Map<String, dynamic> data) => _dio.post('/bookings/packages', data: data);

  Future<Response> updatePackageBooking(int id, Map<String, dynamic> data) => _dio.put('/bookings/packages/$id', data: data);

  Future<Response> deletePackageBooking(int id) => _dio.delete('/bookings/packages/$id');

  // Tours
  Future<Response> getTours() => _dio.get('/tours');

  Future<Response> getTour(int id) => _dio.get('/tours/$id');

  // Tour Bookings
  Future<Response> getTourBookings() => _dio.get('/bookings/tours');

  Future<Response> getTourBooking(int id) => _dio.get('/bookings/tours/$id');

  Future<Response> createTourBooking(Map<String, dynamic> data) => _dio.post('/bookings/tours', data: data);

  Future<Response> updateTourBooking(int id, Map<String, dynamic> data) => _dio.put('/bookings/tours/$id', data: data);

  Future<Response> deleteTourBooking(int id) => _dio.delete('/bookings/tours/$id');

  // Visits
  Future<Response> getVisits() => _dio.get('/visits');

  // Visit Bookings
  Future<Response> getVisitBookings() => _dio.get('/bookings/visits');

  Future<Response> createVisitBooking(Map<String, dynamic> data) => _dio.post('/bookings/visits', data: data);

  Future<Response> updateVisitBooking(String slug, Map<String, dynamic> data) => _dio.put('/bookings/visits/$slug', data: data);

  Future<Response> deleteVisitBooking(String slug) => _dio.delete('/bookings/visits/$slug');
}

final dioClientProvider = Provider<DioClient>(DioClient.new);
