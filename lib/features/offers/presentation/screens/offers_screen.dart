import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/widgets/empty_widget.dart';
import 'package:sama_taxi/core/widgets/error_widget.dart';
import 'package:sama_taxi/core/widgets/loading_widget.dart';
import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';
import 'package:sama_taxi/features/offers/domain/model/offers_model.dart';

class OffersScreen extends ConsumerStatefulWidget {
  const OffersScreen({super.key});

  @override
  ConsumerState<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends ConsumerState<OffersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
  }

  @override
  Widget build(BuildContext context) {
    final offersState = ref.watch(localOffersViewModelProvider);

    return _OffersStateHandler(
      state: offersState,
      onRetry: _handleRetry,
      onRefresh: _handleRefresh,
    );
  }

  void _handleRetry() {
    ref.read(localOffersViewModelProvider.notifier).loadItems();
  }

  Future<void> _handleRefresh() async {
    await ref.read(localOffersViewModelProvider.notifier).loadItems();
  }
}

class _OffersStateHandler extends StatelessWidget {
  const _OffersStateHandler({
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
      return EmptyWidget(message: AppStrings.noData.tr(), icon: Icons.cabin);
    }

    return _OffersList(offers: state.items, onRefresh: onRefresh);
  }
}

class _OffersList extends StatelessWidget {
  const _OffersList({required this.offers, required this.onRefresh});

  final List<Offers> offers;
  final Future<void> Function() onRefresh;

  static const EdgeInsets _listPadding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) => 
  
  LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: offers.isEmpty
              ? const Center(child: Text('No offers available'))
              : ListView.builder(
      shrinkWrap: true,  // Important for nested ListView
      physics: const NeverScrollableScrollPhysics(),  // Let parent handle scrolling
      itemCount: offers.length,
      itemBuilder: (context, index) => OffersCard(offer: offers[index]),
    )
        );
      },
    );
}

class OffersCard extends StatelessWidget {
  const OffersCard({super.key, required this.offer});

  final Offers offer;

  static const EdgeInsets _cardMargin = EdgeInsets.only(bottom: 10);
  static const EdgeInsets _cardPadding = EdgeInsets.all(16);
  static const BorderRadius _cardBorderRadius = BorderRadius.all(
    Radius.circular(12),
  );

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal:15.0),
    child: Card(
        margin: _cardMargin,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: _cardBorderRadius,
        ),
        child: InkWell(
          onTap: () => _navigateToDetails(context),
          borderRadius: _cardBorderRadius,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: _cardBorderRadius,
              color: Colors.white,
              border: Border.all(color: Colors.grey[200]!),
            ),
            height: 150,
            child: Row(
              children: [
                // Discount Tag
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${offer.discount.toInt()}%\noff',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Offer Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Driver Info
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              
                            ),
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  offer.driverName.isNotEmpty 
                                      ? offer.driverName 
                                      : 'No driver name',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      offer.rating.toStringAsFixed(1),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                            
                              ],
                            ),
                          ),
                        ],
                      ),
                        Text(
                        '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                     const SizedBox(height: 5),
                      // Offer Details
                      Text(
                        'Up to 10 km from Wankover city area',
                         style: TextStyle(
                         
                          fontSize: 12,
                          fontWeight:   FontWeight.bold,
                        
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.car_rental_outlined),
                           const SizedBox(width: 4),
                          Text(
                            '${offer.carType} | ',
                            style: TextStyle(
                             fontSize: 12,
                          fontWeight:   FontWeight.bold,
                            ),
                          ), 
                          
                          Text(
                            offer.capacity,
                            style: TextStyle(
                             fontSize: 12,
                          fontWeight:   FontWeight.bold,
                            ),
                          ),
    
    
                         
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Valid Till:',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Text( offer.validUntil, style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),)
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
  );

  void _navigateToDetails(BuildContext context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (context) => OffersDetailsScreen(offer: offer)),
    // );
  }
}

class _OffersCardHeader extends StatelessWidget {
  const _OffersCardHeader({required this.offer});

  final Offers offer;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        Expanded(
          child: Text(
            offer.driverName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        _OffersDateChip(offerDate: offer.validUntil),
      ],
    );
}

class _OffersDateChip extends StatelessWidget {
  const _OffersDateChip({required this.offerDate});

  final String offerDate;

  @override
  Widget build(BuildContext context) => Chip(
      label: Text(offerDate),
      avatar: const Icon(Icons.calendar_today, size: 16),
    );
}


class _OffersCardFooter extends StatelessWidget {
  const _OffersCardFooter({required this.offer});

  final Offers offer;

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _PriceSection(pricePerPerson: offer.discount),
       // _AvailabilitySection(availableSeats: offer.availableSeats),
      ],
    );
}

class _PriceSection extends StatelessWidget {
  const _PriceSection({required this.pricePerPerson});

  final double pricePerPerson;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.pricePerPerson.tr(), style: theme.textTheme.bodySmall),
        Text(
          '\$${pricePerPerson.toStringAsFixed(2)}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _AvailabilitySection extends StatelessWidget {
  const _AvailabilitySection({required this.availableSeats});

  final int availableSeats;

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppStrings.availableSeats.tr(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          availableSeats.toString(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
}