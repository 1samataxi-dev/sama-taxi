// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:sama_taxi/core/accessibility/accessibility_helper.dart';
// import 'package:sama_taxi/core/error/error_handler.dart';
// import 'package:sama_taxi/core/localization/app_strings.dart';
// import 'package:sama_taxi/core/services/logging_service.dart';
// import 'package:sama_taxi/features/offers/domain/model/offers_model.dart';
// import 'package:sama_taxi/features/visits/domain/models/visit.dart';

// /// A comprehensive visit details screen that displays detailed information about a sama_taxi visit.
// ///
// /// This screen provides:
// /// - Enhanced UI with smooth animations
// /// - Accessibility support for screen readers
// /// - Proper error handling and logging
// /// - Responsive design for different screen sizes
// /// - Material 3 design system compliance
// ///
// /// The screen includes route information, visit details, pricing, availability,
// /// and features/amenities with a booking action button.
// ///
// /// Example usage:
// /// ```dart
// /// Navigator.push(
// ///   context,
// ///   MaterialPageRoute(
// ///     builder: (context) => OffersDetailsScreen(visit: myVisit),
// ///   ),
// /// );
// /// ```
// class OffersDetailsScreen extends StatefulWidget {
//   /// Creates a visit details screen.
//   ///
//   /// The [visit] parameter must not be null and should contain
//   /// all necessary visit information.
//   const OffersDetailsScreen({super.key, required this.visit});

//   /// The visit object containing all the details to display
//   final Offers visit;

//   @override
//   State<OffersDetailsScreen> createState() => _OffersDetailsScreenState();
// }

// class _OffersDetailsScreenState extends State<OffersDetailsScreen>
//     with
//         TickerProviderStateMixin,
//         AccessibilityMixin,
//         ErrorHandlerMixin,
//         LoggerMixin {
//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//   }

//   void _initializeAnimations() {
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

//     _slideAnimation =
//         Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
//           CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
//         );

//     // Start animations
//     _fadeController.forward();
//     _slideController.forward();
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: CustomScrollView(
//       slivers: [_buildSliverAppBar(context), _buildContent(context)],
//     ),
//     bottomNavigationBar: _buildBottomBar(context),
//   );

//   /// Enhanced sliver app bar with image and actions
//   Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
//     expandedHeight: 320,
//     pinned: true,
//     elevation: 0,
//     backgroundColor: Theme.of(context).colorScheme.primary,
//     leading: Container(
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.black.withValues(alpha: 0.3),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: AccessibilityHelper.accessibleButton(
//         semanticLabel: 'Go back',
//         tooltip: 'Return to previous screen',
//         onPressed: () {
//           logger.logUserAction('back_button_pressed');
//           Navigator.pop(context);
//         },
//         child: const Icon(Icons.arrow_back, color: Colors.white),
//       ),
//     ),
//     actions: [
//       _buildActionButton(
//         icon: Icons.share,
//         onPressed: () => _handleShare(context),
//       ),
//       _buildActionButton(
//         icon: Icons.favorite_border,
//         onPressed: () => _handleFavorite(context),
//       ),
//     ],
//     flexibleSpace: FlexibleSpaceBar(
//       title: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: Colors.black.withValues(alpha: 0.5),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           widget.visit.type,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//       ),
//       background: _HeaderImage(visit: widget.visit),
//     ),
//   );

//   /// Action button for app bar
//   Widget _buildActionButton({
//     required IconData icon,
//     required VoidCallback onPressed,
//   }) => Container(
//     margin: const EdgeInsets.all(8),
//     decoration: BoxDecoration(
//       color: Colors.black.withValues(alpha: 0.3),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: AccessibilityHelper.accessibleButton(
//       semanticLabel: icon == Icons.share ? 'Share visit' : 'Add to favorites',
//       tooltip: icon == Icons.share
//           ? 'Share this visit with others'
//           : 'Add this visit to your favorites',
//       onPressed: onPressed,
//       child: Icon(icon, color: Colors.white),
//     ),
//   );

//   /// Main content with animations
//   Widget _buildContent(BuildContext context) => SliverToBoxAdapter(
//     child: FadeTransition(
//       opacity: _fadeAnimation,
//       child: SlideTransition(
//         position: _slideAnimation,
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildRouteCard(context),
//               const SizedBox(height: 20),
//               _buildDetailsCard(context),
//               const SizedBox(height: 20),
//               if (widget.visit.description?.isNotEmpty ?? false)
//                 _buildDescriptionCard(context),
//               const SizedBox(height: 20),
//               _buildPricingCard(context),
//               const SizedBox(height: 20),
//               _buildFeaturesCard(context),
//               const SizedBox(height: 32), // Reduced space
//             ],
//           ),
//         ),
//       ),
//     ),
//   );

//   /// Enhanced route information card
//   Widget _buildRouteCard(BuildContext context) => _EnhancedCard(
//     icon: Icons.route,
//     title: 'Route Information',
//     iconColor: Theme.of(context).colorScheme.primary,
//     child: Column(
//       children: [
//         const SizedBox(height: 20),
//         Row(
//           children: [
//             Expanded(
//               child: _LocationItem(
//                 icon: Icons.location_on,
//                 label: 'From',
//                 value: widget.visit.fromDestination,
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 12),
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Theme.of(
//                   context,
//                 ).colorScheme.primary.withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Icon(
//                 Icons.arrow_forward,
//                 color: Theme.of(context).colorScheme.primary,
//                 size: 20,
//               ),
//             ),
//             Expanded(
//               child: _LocationItem(
//                 icon: Icons.place,
//                 label: 'To',
//                 value: widget.visit.toDestination,
//                 color: Colors.green,
//               ),
//             ),
//           ],
//         ),
//         if (widget.visit.destination?.isNotEmpty ?? false) ...[
//           const SizedBox(height: 16),
//           _LocationItem(
//             icon: Icons.explore,
//             label: 'Destination',
//             value: widget.visit.destination!,
//             color: Colors.orange,
//           ),
//         ],
//       ],
//     ),
//   );

//   /// Enhanced visit details card
//   Widget _buildDetailsCard(BuildContext context) => _EnhancedCard(
//     icon: Icons.info_outline,
//     title: 'Visit Details',
//     iconColor: Colors.blue,
//     child: Column(
//       children: [
//         const SizedBox(height: 20),
//         Row(
//           children: [
//             Expanded(
//               child: _DetailItem(
//                 icon: Icons.calendar_today,
//                 label: 'Visit Date',
//                 value: DateFormat(
//                   'EEEE, MMM dd, yyyy',
//                 ).format(widget.visit.visitDate),
//                 color: Colors.blue,
//               ),
//             ),
//             Expanded(
//               child: _DetailItem(
//                 icon: Icons.category,
//                 label: 'Type',
//                 value: widget.visit.type,
//                 color: Colors.purple,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );

//   /// Enhanced description card
//   Widget _buildDescriptionCard(BuildContext context) => _EnhancedCard(
//     icon: Icons.description,
//     title: 'Description',
//     iconColor: Colors.orange,
//     child: Column(
//       children: [
//         const SizedBox(height: 16),
//         Text(
//           widget.visit.description!,
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//             height: 1.6,
//             color: Theme.of(
//               context,
//             ).colorScheme.onSurface.withValues(alpha: 0.8),
//           ),
//         ),
//       ],
//     ),
//   );

//   /// Enhanced pricing card
//   Widget _buildPricingCard(BuildContext context) => DecoratedBox(
//     decoration: BoxDecoration(
//       color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
//       borderRadius: BorderRadius.circular(20),
//       border: Border.all(
//         color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
//       ),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.primary,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.attach_money,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 'Pricing & Availability',
//                 style: Theme.of(
//                   context,
//                 ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(child: _buildPriceContainer(context)),
//               const SizedBox(width: 16),
//               Expanded(child: _buildAvailabilityContainer(context)),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );

//   /// Price container widget
//   Widget _buildPriceContainer(BuildContext context) => Container(
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withValues(alpha: 0.05),
//           blurRadius: 8,
//           offset: const Offset(0, 2),
//         ),
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           AppStrings.pricePerPerson.tr(),
//           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//             color: Theme.of(
//               context,
//             ).colorScheme.onSurface.withValues(alpha: 0.7),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           '\$${widget.visit.pricePerPerson.toStringAsFixed(2)}',
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//             color: Theme.of(context).colorScheme.primary,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     ),
//   );

//   /// Availability container widget
//   Widget _buildAvailabilityContainer(BuildContext context) {
//     final isAvailable = widget.visit.availableSeats > 0;
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             AppStrings.availableSeats.tr(),
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(
//               color: Theme.of(
//                 context,
//               ).colorScheme.onSurface.withValues(alpha: 0.7),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: isAvailable
//                   ? Colors.green.withValues(alpha: 0.1)
//                   : Colors.red.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isAvailable ? Colors.green : Colors.red,
//               ),
//             ),
//             child: Text(
//               '${widget.visit.availableSeats} seats',
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                 color: isAvailable ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Features and amenities card
//   Widget _buildFeaturesCard(BuildContext context) {
//     final features = [
//       {'icon': Icons.wifi, 'label': 'Free WiFi', 'available': true},
//       {'icon': Icons.restaurant, 'label': 'Meals Included', 'available': true},
//       {
//         'icon': Icons.local_parking,
//         'label': 'Parking',
//         'available': widget.visit.availableSeats > 5,
//       },
//       {'icon': Icons.ac_unit, 'label': 'Air Conditioning', 'available': true},
//     ];

//     return _EnhancedCard(
//       icon: Icons.star,
//       title: 'Features & Amenities',
//       iconColor: Colors.green,
//       child: Column(
//         children: [
//           const SizedBox(height: 16),
//           Wrap(
//             spacing: 12,
//             runSpacing: 12,
//             children: features.map((feature) {
//               final isAvailable = feature['available']! as bool;
//               return _FeatureChip(
//                 icon: feature['icon']! as IconData,
//                 label: feature['label']! as String,
//                 isAvailable: isAvailable,
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Enhanced bottom bar with booking button
//   Widget _buildBottomBar(BuildContext context) {
//     final isAvailable = widget.visit.availableSeats > 0;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 20,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: SizedBox(
//           width: double.infinity,
//           height: 56,
//           child: ElevatedButton(
//             onPressed: isAvailable ? () => _handleBooking(context) : null,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: isAvailable
//                   ? Theme.of(context).colorScheme.primary
//                   : (isDark ? Colors.grey.shade800 : Colors.grey.shade300),
//               foregroundColor: Colors.white,
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//             child: Text(
//               isAvailable ? 'Book Now' : 'Sold Out',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Event handlers
//   void _handleBooking(BuildContext context) {
//     logger.logUserAction(
//       'booking_attempted',
//       context: {
//         'visit_id': widget.visit.id,
//         'visit_type': widget.visit.type,
//         'available_seats': widget.visit.availableSeats,
//       },
//     );

//     announceMessage('Booking process started');

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('Booking functionality will be implemented soon'),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//       ),
//     );
//   }

//   void _handleShare(BuildContext context) {
//     logger.logUserAction(
//       'share_attempted',
//       context: {'visit_id': widget.visit.id, 'visit_type': widget.visit.type},
//     );

//     announceMessage('Share options opened');

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Share functionality will be implemented soon'),
//       ),
//     );
//   }

//   void _handleFavorite(BuildContext context) {
//     logger.logUserAction(
//       'favorite_attempted',
//       context: {'visit_id': widget.visit.id, 'visit_type': widget.visit.type},
//     );

//     announceMessage('Added to favorites');

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Favorite functionality will be implemented soon'),
//       ),
//     );
//   }
// }

// /// Enhanced card widget with consistent styling
// class _EnhancedCard extends StatelessWidget {
//   const _EnhancedCard({
//     required this.icon,
//     required this.title,
//     required this.iconColor,
//     required this.child,
//   });

//   final IconData icon;
//   final String title;
//   final Color iconColor;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) => DecoratedBox(
//     decoration: BoxDecoration(
//       color: Theme.of(context).colorScheme.surface,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withValues(alpha: 0.05),
//           blurRadius: 10,
//           offset: const Offset(0, 4),
//         ),
//       ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: iconColor.withValues(alpha: 0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, color: iconColor, size: 20),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 title,
//                 style: Theme.of(
//                   context,
//                 ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           child,
//         ],
//       ),
//     ),
//   );
// }

// /// Header image widget with gradient overlay
// class _HeaderImage extends StatelessWidget {
//   const _HeaderImage({required this.visit});

//   final Visit visit;

//   @override
//   Widget build(BuildContext context) => DecoratedBox(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [
//           Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
//           Theme.of(context).colorScheme.primary,
//         ],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//     ),
//     child: visit.featuredImage?.isNotEmpty ?? false
//         ? Stack(
//             fit: StackFit.expand,
//             children: [
//               Image.network(
//                 visit.featuredImage!,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) =>
//                     const _PlaceholderImage(),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.transparent,
//                       Colors.black.withValues(alpha: 0.7),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//             ],
//           )
//         : const _PlaceholderImage(),
//   );
// }

// /// Placeholder image widget
// class _PlaceholderImage extends StatelessWidget {
//   const _PlaceholderImage();

//   @override
//   Widget build(BuildContext context) => DecoratedBox(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [
//           Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
//           Theme.of(context).colorScheme.primary,
//         ],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//     ),
//     child: const Center(
//       child: Icon(Icons.place, size: 80, color: Colors.white),
//     ),
//   );
// }

// /// Location item widget
// class _LocationItem extends StatelessWidget {
//   const _LocationItem({
//     required this.icon,
//     required this.label,
//     required this.value,
//     required this.color,
//   });

//   final IconData icon;
//   final String label;
//   final String value;
//   final Color color;

//   @override
//   Widget build(BuildContext context) => Container(
//     padding: const EdgeInsets.all(12),
//     decoration: BoxDecoration(
//       color: color.withValues(alpha: 0.1),
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: color.withValues(alpha: 0.3)),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, size: 16, color: color),
//             const SizedBox(width: 6),
//             Text(
//               label,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                 color: color,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
//         ),
//       ],
//     ),
//   );
// }

// /// Detail item widget
// class _DetailItem extends StatelessWidget {
//   const _DetailItem({
//     required this.icon,
//     required this.label,
//     required this.value,
//     required this.color,
//   });

//   final IconData icon;
//   final String label;
//   final String value;
//   final Color color;

//   @override
//   Widget build(BuildContext context) => Container(
//     padding: const EdgeInsets.all(12),
//     decoration: BoxDecoration(
//       color: color.withValues(alpha: 0.1),
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: color.withValues(alpha: 0.3)),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, size: 16, color: color),
//             const SizedBox(width: 6),
//             Text(
//               label,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                 color: color,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
//         ),
//       ],
//     ),
//   );
// }

// /// Feature chip widget
// class _FeatureChip extends StatelessWidget {
//   const _FeatureChip({
//     required this.icon,
//     required this.label,
//     required this.isAvailable,
//   });

//   final IconData icon;
//   final String label;
//   final bool isAvailable;

//   @override
//   Widget build(BuildContext context) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//     decoration: BoxDecoration(
//       color: isAvailable
//           ? Colors.green.withValues(alpha: 0.1)
//           : Colors.grey.withValues(alpha: 0.1),
//       borderRadius: BorderRadius.circular(20),
//       border: Border.all(color: isAvailable ? Colors.green : Colors.grey),
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 16, color: isAvailable ? Colors.green : Colors.grey),
//         const SizedBox(width: 6),
//         Text(
//           label,
//           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//             color: isAvailable ? Colors.green : Colors.grey,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     ),
//   );
// }
