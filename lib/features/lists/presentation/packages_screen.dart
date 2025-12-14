// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sama_taxi/core/localization/app_strings.dart';
// import 'package:sama_taxi/core/widgets/empty_widget.dart';
// import 'package:sama_taxi/core/widgets/error_widget.dart';
// import 'package:sama_taxi/core/widgets/loading_widget.dart';
// import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';
// import 'package:sama_taxi/features/packages/domain/models/package.dart';

// class PackagesScreen extends ConsumerStatefulWidget {
//   const PackagesScreen({super.key});

//   @override
//   ConsumerState<PackagesScreen> createState() => _PackagesScreenState();
// }

// class _PackagesScreenState extends ConsumerState<PackagesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(packagesViewModelProvider.notifier).loadItems();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final packagesState = ref.watch(packagesViewModelProvider);

//     return _PackagesStateHandler(
//       state: packagesState,
//       onRetry: _handleRetry,
//       onRefresh: _handleRefresh,
//     );
//   }

//   void _handleRetry() {
//     ref.read(packagesViewModelProvider.notifier).loadItems();
//   }

//   Future<void> _handleRefresh() async {
//     await ref.read(packagesViewModelProvider.notifier).loadItems();
//   }
// }

// class _PackagesStateHandler extends StatelessWidget {
//   const _PackagesStateHandler({
//     required this.state,
//     required this.onRetry,
//     required this.onRefresh,
//   });

//   final dynamic state;
//   final VoidCallback onRetry;
//   final Future<void> Function() onRefresh;

//   @override
//   Widget build(BuildContext context) {
//     if (state.isLoading) {
//       return const LoadingWidget();
//     }

//     if (state.error != null) {
//       return ErrorDisplayWidget(message: state.error, onRetry: onRetry);
//     }

//     if (state.items.isEmpty) {
//       return EmptyWidget(
//         message: AppStrings.noData.tr(),
//         icon: Icons.card_sama_taxi,
//       );
//     }

//     return _PackagesList(packages: state.items, onRefresh: onRefresh);
//   }
// }

// class _PackagesList extends StatelessWidget {
//   const _PackagesList({required this.packages, required this.onRefresh});

//   final List<Package> packages;
//   final Future<void> Function() onRefresh;

//   static const EdgeInsets _listPadding = EdgeInsets.all(16);

//   @override
//   Widget build(BuildContext context) => RefreshIndicator(
//       onRefresh: onRefresh,
//       child: ListView.builder(
//         padding: _listPadding,
//         itemCount: packages.length,
//         itemBuilder: (context, index) => PackageCard(package: packages[index]),
//       ),
//     );
// }

// class PackageCard extends StatelessWidget {
//   const PackageCard({super.key, required this.package});

//   final Package package;

//   static const EdgeInsets _cardMargin = EdgeInsets.only(bottom: 16);
//   static const EdgeInsets _cardPadding = EdgeInsets.all(16);

//   @override
//   Widget build(BuildContext context) => Card(
//       margin: _cardMargin,
//       child: Padding(
//         padding: _cardPadding,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _PackageCardHeader(package: package),
//             const SizedBox(height: 8),
//             _PackageCardLocation(package: package),
//             const SizedBox(height: 8),
//             _PackageCardDescription(description: package.description),
//             const SizedBox(height: 12),
//             _PackageCardInclusions(package: package),
//             const SizedBox(height: 12),
//             _PackageCardPrice(price: package.price),
//           ],
//         ),
//       ),
//     );
// }

// class _PackageCardHeader extends StatelessWidget {
//   const _PackageCardHeader({required this.package});

//   final Package package;

//   @override
//   Widget build(BuildContext context) => Text(package.title, style: Theme.of(context).textTheme.titleLarge);
// }

// class _PackageCardLocation extends StatelessWidget {
//   const _PackageCardLocation({required this.package});

//   final Package package;

//   @override
//   Widget build(BuildContext context) => Row(
//       children: [
//         const Icon(Icons.location_on, size: 16),
//         const SizedBox(width: 4),
//         Expanded(
//           child: Text(
//             package.destination,
//             style: Theme.of(context).textTheme.bodyMedium,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         const SizedBox(width: 8),
//         _PackageDuration(durationDays: package.durationDays),
//       ],
//     );
// }

// class _PackageDuration extends StatelessWidget {
//   const _PackageDuration({required this.durationDays});

//   final int durationDays;

//   @override
//   Widget build(BuildContext context) => Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.primaryContainer,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         '$durationDays ${AppStrings.durationDays.tr()}',
//         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//           color: Theme.of(context).colorScheme.onPrimaryContainer,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
// }

// class _PackageCardDescription extends StatelessWidget {
//   const _PackageCardDescription({required this.description});

//   final String description;

//   static const int _maxLines = 3;

//   @override
//   Widget build(BuildContext context) => Text(
//       description,
//       style: Theme.of(context).textTheme.bodyMedium,
//       maxLines: _maxLines,
//       overflow: TextOverflow.ellipsis,
//     );
// }

// class _PackageCardInclusions extends StatelessWidget {
//   const _PackageCardInclusions({required this.package});

//   final Package package;

//   static const double _chipSpacing = 8;

//   @override
//   Widget build(BuildContext context) {
//     final inclusions = <Widget>[];

//     if (package.includesFlight) {
//       inclusions.add(
//         _InclusionChip(
//           label: AppStrings.includesFlight.tr(),
//           icon: Icons.flight,
//         ),
//       );
//     }

//     if (package.includesHotel) {
//       inclusions.add(
//         _InclusionChip(label: AppStrings.includesHotel.tr(), icon: Icons.hotel),
//       );
//     }

//     if (package.includesTour) {
//       inclusions.add(
//         _InclusionChip(label: AppStrings.includesTour.tr(), icon: Icons.tour),
//       );
//     }

//     if (inclusions.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return Wrap(spacing: _chipSpacing, children: inclusions);
//   }
// }

// class _InclusionChip extends StatelessWidget {
//   const _InclusionChip({required this.label, required this.icon});

//   final String label;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) => Chip(label: Text(label), avatar: Icon(icon, size: 16));
// }

// class _PackageCardPrice extends StatelessWidget {
//   const _PackageCardPrice({required this.price});

//   final double price;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(AppStrings.price.tr(), style: theme.textTheme.bodySmall),
//         Text(
//           '\$${price.toStringAsFixed(2)}',
//           style: theme.textTheme.titleLarge?.copyWith(
//             color: theme.colorScheme.primary,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }
