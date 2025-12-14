    
 import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalListsViewModel<T> extends StateNotifier<ListsState<T>> {
  final List<T> localItems;

  LocalListsViewModel(this.localItems) : super(ListsState<T>()) {
    // Load local items immediately
    loadItems();
  }

  Future<void> loadItems({bool forceRefresh = false}) async {
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