// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sama_taxi/core/constants/app_icons.dart';
// import 'package:sama_taxi/core/localization/app_strings.dart';
// import 'package:sama_taxi/core/widgets/empty_widget.dart';
// import 'package:sama_taxi/core/widgets/error_widget.dart';
// import 'package:sama_taxi/core/widgets/loading_widget.dart';
// import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';
// import 'package:sama_taxi/features/tours/domain/models/tour.dart';

// class ToursScreen extends ConsumerStatefulWidget {
//   const ToursScreen({super.key});

//   @override
//   ConsumerState<ToursScreen> createState() => _ToursScreenState();
// }

// class _ToursScreenState extends ConsumerState<ToursScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(toursViewModelProvider.notifier).loadItems();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(toursViewModelProvider);

//     if (state.isLoading) {
//       return const LoadingWidget();
//     }

//     if (state.error != null) {
//       return ErrorDisplayWidget(
//         message: state.error,
//         onRetry: () => ref.read(toursViewModelProvider.notifier).loadItems(),
//       );
//     }

//     if (state.items.isEmpty) {
//       return EmptyWidget(
//         message: AppStrings.noData.tr(),
//         iconPath: AppIcons.car,
//       );
//     }

//     return RefreshIndicator(
//       onRefresh: () async {
//         await ref.read(toursViewModelProvider.notifier).loadItems();
//       },
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: state.items.length,
//         itemBuilder: (context, index) {
//           final tour = state.items[index];
//           return TourCard(tour: tour);
//         },
//       ),
//     );
//   }
// }

// class TourCard extends StatelessWidget {
//   const TourCard({super.key, required this.tour});

//   final Tour tour;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return _TourCardContainer(
//       isDark: isDark,
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _TourCardHeader(tour: tour),
//             const SizedBox(height: 16),
//             _TourDescription(description: tour.description),
//             const SizedBox(height: 16),
//             _TourSchedule(startTime: tour.startTime),
//             if (tour.includes != null) ...[
//               const SizedBox(height: 12),
//               _TourIncludes(includes: tour.includes!),
//             ],
//             const SizedBox(height: 16),
//             _TourPricing(tour: tour, isDark: isDark),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// Tour card container with gradient background
// class _TourCardContainer extends StatelessWidget {
//   const _TourCardContainer({required this.isDark, required this.child});

//   final bool isDark;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) => Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         gradient: isDark
//             ? LinearGradient(
//                 colors: [Colors.grey.shade800, Colors.grey.shade900],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               )
//             : const LinearGradient(
//                 colors: [Colors.white, Color(0xFFF8FAFC)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: child,
//     );
// }

// /// Tour card header with gradient background
// class _TourCardHeader extends StatelessWidget {
//   const _TourCardHeader({required this.tour});

//   final Tour tour;

//   static const _headerGradient = LinearGradient(
//     colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   @override
//   Widget build(BuildContext context) => Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         gradient: _headerGradient,
//         borderRadius: BorderRadius.all(Radius.circular(16)),
//       ),
//       child: Row(
//         children: [
//           const _TourIcon(),
//           const SizedBox(width: 12),
//           Expanded(child: _TourHeaderInfo(tour: tour)),
//           _TourDurationBadge(durationHours: tour.durationHours),
//         ],
//       ),
//     );
// }

// /// Tour icon widget
// class _TourIcon extends StatelessWidget {
//   const _TourIcon();

//   @override
//   Widget build(BuildContext context) => Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: AppIcons.carIcon(color: Colors.white, size: 20),
//     );
// }

// /// Tour header information
// class _TourHeaderInfo extends StatelessWidget {
//   const _TourHeaderInfo({required this.tour});

//   final Tour tour;

//   @override
//   Widget build(BuildContext context) => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           tour.title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Row(
//           children: [
//             AppIcons.locationIcon(color: Colors.white70, size: 16),
//             const SizedBox(width: 4),
//             Text(
//               tour.destination,
//               style: const TextStyle(color: Colors.white70, fontSize: 14),
//             ),
//           ],
//         ),
//       ],
//     );
// }

// /// Tour duration badge
// class _TourDurationBadge extends StatelessWidget {
//   const _TourDurationBadge({required this.durationHours});

//   final int durationHours;

//   @override
//   Widget build(BuildContext context) => Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         '${durationHours}h',
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
// }

// /// Tour description
// class _TourDescription extends StatelessWidget {
//   const _TourDescription({required this.description});

//   final String description;

//   static const int _maxLines = 3;

//   @override
//   Widget build(BuildContext context) => Text(
//       description,
//       style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
//       maxLines: _maxLines,
//       overflow: TextOverflow.ellipsis,
//     );
// }

// /// Tour schedule information
// class _TourSchedule extends StatelessWidget {
//   const _TourSchedule({required this.startTime});

//   final DateTime startTime;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.grey.shade700 : Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           AppIcons.calendarIcon(
//             size: 20,
//             color: Theme.of(context).colorScheme.primary,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             DateFormat('MMM dd, yyyy • HH:mm').format(startTime),
//             style: Theme.of(
//               context,
//             ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Tour includes section
// class _TourIncludes extends StatelessWidget {
//   const _TourIncludes({required this.includes});

//   final String includes;

//   @override
//   Widget build(BuildContext context) => Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.green.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.green.withOpacity(0.3)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AppIcons.starIcon(filled: true, color: Colors.green, size: 20),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               includes,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                 color: Colors.green.shade700,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
// }

// /// Tour pricing and availability
// class _TourPricing extends StatelessWidget {
//   const _TourPricing({required this.tour, required this.isDark});

//   final Tour tour;
//   final bool isDark;

//   @override
//   Widget build(BuildContext context) => Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _TourPriceSection(pricePerPerson: tour.pricePerPerson, isDark: isDark),
//         _TourAvailabilitySection(availableSeats: tour.availableSeats),
//       ],
//     );
// }

// /// Tour price section
// class _TourPriceSection extends StatelessWidget {
//   const _TourPriceSection({required this.pricePerPerson, required this.isDark});

//   final double pricePerPerson;
//   final bool isDark;

//   static const _priceGradient = LinearGradient(
//     colors: [Color(0xFFF59E0B), Color(0xFFEC4899)],
//   );

//   @override
//   Widget build(BuildContext context) => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           AppStrings.pricePerPerson.tr(),
//           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//             color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: const BoxDecoration(
//             gradient: _priceGradient,
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//           ),
//           child: Text(
//             '\$${pricePerPerson.toStringAsFixed(2)}',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
// }

// /// Tour availability section
// class _TourAvailabilitySection extends StatelessWidget {
//   const _TourAvailabilitySection({required this.availableSeats});

//   final int availableSeats;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final hasSeats = availableSeats > 5;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Text(
//           AppStrings.availableSeats.tr(),
//           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//             color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: hasSeats
//                 ? Colors.green.withOpacity(0.2)
//                 : Colors.orange.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: hasSeats ? Colors.green : Colors.orange),
//           ),
//           child: Text(
//             availableSeats.toString(),
//             style: TextStyle(
//               color: hasSeats ? Colors.green.shade700 : Colors.orange.shade700,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
