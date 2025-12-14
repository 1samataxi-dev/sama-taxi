import 'package:flutter/material.dart';
import 'package:sama_taxi/features/offers/domain/model/offers_model.dart';

class OffersCard extends StatelessWidget {
  const OffersCard({super.key, required this.offer});

  final Offers offer;

  static const EdgeInsets _cardMargin = EdgeInsets.only(bottom: 16);
  static const EdgeInsets _cardPadding = EdgeInsets.all(16);
  static const BorderRadius _cardBorderRadius = BorderRadius.all(
    Radius.circular(12),
  );

  @override
  Widget build(BuildContext context) => Card(
      margin: _cardMargin,
      child: InkWell(
        onTap: () => _navigateToDetails(context),
        borderRadius: _cardBorderRadius,
        child: Padding(
          padding: _cardPadding,
          child: ListTile(
                title: Text(offer.driverName.isNotEmpty 
                    ? offer.driverName 
                    : 'No driver name'),
                subtitle: Text('${offer.carType} • ${offer.capacity}'),
                trailing: Text(offer.discount.toString()),
              )
        ),
      ),
    );

  void _navigateToDetails(BuildContext context) {
    
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (context) => OffersDetailsScreen(offer: offer)),
    // );
  }
}