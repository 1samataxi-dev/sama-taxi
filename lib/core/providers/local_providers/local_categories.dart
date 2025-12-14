    
 import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';
import 'package:sama_taxi/features/taxify/domain/entities/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class LocalCategoriesViewModel extends StateNotifier<ListsState<CategoryModel>> {
  LocalCategoriesViewModel(this.localItems) : super(ListsState<CategoryModel>()) {
    // Load local items immediately
    loadItems();
  }

  final List<CategoryModel> localItems;

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

