import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/widgets/empty_widget.dart';
import 'package:sama_taxi/core/widgets/error_widget.dart';
import 'package:sama_taxi/core/widgets/loading_widget.dart';
import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';
import 'package:sama_taxi/features/taxify/domain/entities/category.dart';
import 'package:sama_taxi/features/taxify/presentation/widgets/category_card.dart';

class TopCategories extends ConsumerStatefulWidget {
  const TopCategories({super.key});

  @override
  ConsumerState<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends ConsumerState<TopCategories> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(localcategoriesViewModelProvider.notifier).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(localcategoriesViewModelProvider);

    return _CategoriesStateHandler(
      state: categoriesState,
      onRetry: _handleRetry,
      onRefresh: _handleRefresh,
    );
  }

  void _handleRetry() {
    ref.read(localcategoriesViewModelProvider.notifier).loadItems();
  }

  Future<void> _handleRefresh() async {
    await ref.read(localcategoriesViewModelProvider.notifier).loadItems();
  }
}

class _CategoriesStateHandler extends StatelessWidget {
  const _CategoriesStateHandler({
    required this.state,
    required this.onRetry,
    required this.onRefresh,
  });

  final dynamic state;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const LoadingWidget();
    }

    if (state.error != null) {
      return ErrorDisplayWidget(message: state.error, onRetry: onRetry);
    }

    if (state.items.isEmpty) {
      return EmptyWidget(message: AppStrings.noData.tr(), icon: Icons.place);
    }

    return _CategoriesList(categories: state.items, onRefresh: onRefresh);
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList({required this.categories, required this.onRefresh});

  final List<CategoryModel> categories;
  final Future<void> Function() onRefresh;

  static const EdgeInsets _listPadding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) => RefreshIndicator(
      onRefresh: onRefresh,
      child: _buildCategories(
 categories
      )
    
    );


  Widget _buildCategories(List<CategoryModel> categories) {
    return  Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,spacing: 5,
      children: List.generate(
        categories.length,
        
        (index)=>
        
        CategoryCard(
          icon: categories[index].imageAsset,
          label: categories[index].routeName,
        )
    )
    );
  }
}
