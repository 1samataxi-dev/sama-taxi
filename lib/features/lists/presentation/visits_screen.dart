import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/widgets/empty_widget.dart';
import 'package:sama_taxi/core/widgets/error_widget.dart';
import 'package:sama_taxi/core/widgets/loading_widget.dart';
import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';
import 'package:sama_taxi/features/visits/domain/models/visit.dart';
import 'package:sama_taxi/features/visits/presentation/visit_details_screen.dart';

class VisitsScreen extends ConsumerStatefulWidget {
  const VisitsScreen({super.key});

  @override
  ConsumerState<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends ConsumerState<VisitsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(visitsViewModelProvider.notifier).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final visitsState = ref.watch(visitsViewModelProvider);

    return _VisitsStateHandler(
      state: visitsState,
      onRetry: _handleRetry,
      onRefresh: _handleRefresh,
    );
  }

  void _handleRetry() {
    ref.read(visitsViewModelProvider.notifier).loadItems();
  }

  Future<void> _handleRefresh() async {
    await ref.read(visitsViewModelProvider.notifier).loadItems();
  }
}

class _VisitsStateHandler extends StatelessWidget {
  const _VisitsStateHandler({
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

    return _VisitsList(visits: state.items, onRefresh: onRefresh);
  }
}

class _VisitsList extends StatelessWidget {
  const _VisitsList({required this.visits, required this.onRefresh});

  final List<Visit> visits;
  final Future<void> Function() onRefresh;

  static const EdgeInsets _listPadding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) => RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: _listPadding,
        itemCount: visits.length,
        itemBuilder: (context, index) => VisitCard(visit: visits[index]),
      ),
    );
}

class VisitCard extends StatelessWidget {
  const VisitCard({super.key, required this.visit});

  final Visit visit;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _VisitCardHeader(visit: visit),
              const SizedBox(height: 8),
              _VisitCardRoute(visit: visit),
              if (visit.destination?.isNotEmpty ?? false) ...[
                const SizedBox(height: 4),
                _VisitCardDestination(destination: visit.destination!),
              ],
              if (visit.description?.isNotEmpty ?? false) ...[
                const SizedBox(height: 8),
                _VisitCardDescription(description: visit.description!),
              ],
              const SizedBox(height: 12),
              _VisitCardFooter(visit: visit),
            ],
          ),
        ),
      ),
    );

  void _navigateToDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => VisitDetailsScreen(visit: visit)),
    );
  }
}

class _VisitCardHeader extends StatelessWidget {
  const _VisitCardHeader({required this.visit});

  final Visit visit;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        Expanded(
          child: Text(
            visit.type,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        _VisitDateChip(visitDate: visit.visitDate),
      ],
    );
}

class _VisitDateChip extends StatelessWidget {
  const _VisitDateChip({required this.visitDate});

  final DateTime visitDate;

  @override
  Widget build(BuildContext context) => Chip(
      label: Text(DateFormat('MMM dd').format(visitDate)),
      avatar: const Icon(Icons.calendar_today, size: 16),
    );
}

class _VisitCardRoute extends StatelessWidget {
  const _VisitCardRoute({required this.visit});

  final Visit visit;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return Row(
      children: [
        const Icon(Icons.location_on, size: 16),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            visit.fromDestination,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.arrow_forward, size: 16),
        ),
        Flexible(
          child: Text(
            visit.toDestination,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _VisitCardDestination extends StatelessWidget {
  const _VisitCardDestination({required this.destination});

  final String destination;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        const Icon(Icons.place, size: 16),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            destination,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
}

class _VisitCardDescription extends StatelessWidget {
  const _VisitCardDescription({required this.description});

  final String description;

  static const int _maxLines = 2;

  @override
  Widget build(BuildContext context) => Text(
      description,
      style: Theme.of(context).textTheme.bodyMedium,
      maxLines: _maxLines,
      overflow: TextOverflow.ellipsis,
    );
}

class _VisitCardFooter extends StatelessWidget {
  const _VisitCardFooter({required this.visit});

  final Visit visit;

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _PriceSection(pricePerPerson: visit.pricePerPerson),
        _AvailabilitySection(availableSeats: visit.availableSeats),
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
