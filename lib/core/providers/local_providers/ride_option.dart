    
 import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';
import 'package:sama_taxi/features/outstation/domain/models/ride_option.dart';
import 'package:sama_taxi/features/taxify/domain/entities/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class LocalOptionViewModel extends StateNotifier<ListsState<RideOption>> {
  LocalOptionViewModel(this.localItems) : super(ListsState<RideOption>()) {
    // Load local items immediately
    loadItems();
  }

  final List<RideOption> localItems;

  Future<void> loadItems() async {
    state = state.copyWith(
      isLoading: false,
      items: localItems,
      error: null,
    );
  }

  Future<void> refresh() async {
    await loadItems();
  }
}

