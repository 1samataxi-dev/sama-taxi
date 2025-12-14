import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/constants/api_endpoints.dart';
import 'package:sama_taxi/core/network/enhanced_network_handler.dart';
import 'package:sama_taxi/core/network/network_result.dart';
import 'package:sama_taxi/core/providers/local_providers/local_categories.dart';
import 'package:sama_taxi/core/providers/local_providers/local_offers.dart';
import 'package:sama_taxi/core/providers/local_providers/ride_option.dart';
import 'package:sama_taxi/features/offers/domain/model/offers_model.dart';
import 'package:sama_taxi/features/outstation/domain/models/ride_option.dart';
import 'package:sama_taxi/features/taxify/domain/entities/category.dart';
import 'package:sama_taxi/features/visits/domain/models/visit.dart';

class ListsState<T> {

  ListsState({this.isLoading = false, this.items = const [], this.error});
  final bool isLoading;
  final List<T> items;
  final String? error;

  ListsState<T> copyWith({bool? isLoading, List<T>? items, String? error}) => ListsState<T>(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error,
    );
}

class ListsViewModel<T> extends StateNotifier<ListsState<T>> {

  ListsViewModel(this._networkHandler, this._fromJson, this._endpoint)
    : super(ListsState<T>());
  final EnhancedNetworkHandler _networkHandler;
  final T Function(Map<String, dynamic>) _fromJson;
  final String _endpoint;

  Future<void> loadItems({bool forceRefresh = false}) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _networkHandler.getCached<List<T>>(
      _endpoint,
      parser: (data) {
        var items = <dynamic>[];

        try {
          // Debug: Print the response structure
          print('API Response for $_endpoint: $data');

          if (data is List) {
            // Direct list response
            items = data;
          } else if (data is Map<String, dynamic>) {
            // Check if response has nested structure with 'data' field
            if (data.containsKey('data')) {
              final responseData = data['data'];

              if (responseData is List) {
                // data is directly a list
                items = responseData;
              } else if (responseData is Map<String, dynamic>) {
                // data is an object, extract the appropriate list based on endpoint
                final endpoint = _endpoint.toLowerCase();

                if (endpoint.contains('hotel')) {
                  items = (responseData['hotels'] as List<dynamic>?) ?? [];
                } else if (endpoint.contains('package')) {
                  items = (responseData['packages'] as List<dynamic>?) ?? [];
                } else if (endpoint.contains('tour')) {
                  items = (responseData['tours'] as List<dynamic>?) ?? [];
                } else if (endpoint.contains('visit')) {
                  items = (responseData['visits'] as List<dynamic>?) ?? [];
                } else if (endpoint.contains('booking')) {
                  items = (responseData['bookings'] as List<dynamic>?) ?? [];
                } else {
                  // Fallback: look for any list in the response data
                  for (final value in responseData.values) {
                    if (value is List) {
                      items = List<dynamic>.from(value);
                      break;
                    }
                  }
                }
              }
            } else {
              // No 'data' field, look for any list in the top-level response
              for (final value in data.values) {
                if (value is List) {
                  items = List<dynamic>.from(value);
                  break;
                }
              }
            }
          }
        } catch (e) {
          // If parsing fails, return empty list and log the error
          print('Error parsing response for $_endpoint: $e');
          print('Response data: $data');
          items = [];
        }

        return items
            .map((json) => _fromJson(json as Map<String, dynamic>))
            .toList();
      },
      cacheTtl: const Duration(minutes: 30),
      forceRefresh: forceRefresh,
    );

    result.when(
      onSuccess: (items) {
        state = state.copyWith(isLoading: false, items: items);
      },
      onFailure: (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<void> refresh() async {
    await loadItems(forceRefresh: true);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}



// Visits
final visitsViewModelProvider =
    StateNotifierProvider<ListsViewModel<Visit>, ListsState<Visit>>((ref) => ListsViewModel<Visit>(
        ref.read(enhancedNetworkHandlerProvider),
        Visit.fromJson,
        ApiEndpoints.visits,
      ));
      
// offers
final offersViewModelProvider =
    StateNotifierProvider<ListsViewModel<Offers>, ListsState<Offers>>((ref) => ListsViewModel<Offers>(
        ref.read(enhancedNetworkHandlerProvider),
        Offers.fromJson,
        ApiEndpoints.offers,
      )); 


// Local offers view model provider
final localOffersViewModelProvider = StateNotifierProvider<LocalListsViewModel<Offers>, ListsState<Offers>>(
  (ref) => LocalListsViewModel<Offers>(localOffers),
); // Local offers view model provider


      //categories
final categoriesViewModelProvider =
    StateNotifierProvider<ListsViewModel<CategoryModel>,
     ListsState<CategoryModel>>((ref) => ListsViewModel<CategoryModel>(
        ref.read(enhancedNetworkHandlerProvider),
        CategoryModel.fromJson,
        ApiEndpoints.categories,
      ));

final categoriesOptionsViewModelProvider =
    StateNotifierProvider<ListsViewModel<RideOption>,
     ListsState<RideOption>>((ref) => ListsViewModel<RideOption>(
        ref.read(enhancedNetworkHandlerProvider),
        RideOption.fromMap,
        ApiEndpoints.categories,
      ));

      /// local categories
// Then use it like this:
final localcategoriesViewModelProvider =
    StateNotifierProvider<LocalCategoriesViewModel, ListsState<CategoryModel>>(
  (ref) => LocalCategoriesViewModel(localcategories),
);

  // Then use it like this:
final localcategoriesOptionViewModelProvider =
    StateNotifierProvider<LocalOptionViewModel, ListsState<RideOption>>(
  (ref) => LocalOptionViewModel(localRideOptions),
);
  
  