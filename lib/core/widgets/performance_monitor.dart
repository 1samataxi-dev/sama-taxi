import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A widget that helps monitor rebuild performance in debug mode
///
/// This widget wraps other widgets and logs when they rebuild,
/// helping identify unnecessary rebuilds during development.
class PerformanceMonitor extends StatelessWidget {
  const PerformanceMonitor({
    super.key,
    required this.child,
    required this.name,
    this.logRebuilds = true,
  });

  final Widget child;
  final String name;
  final bool logRebuilds;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode && logRebuilds) {
      debugPrint('🔄 Rebuilding: $name');
    }
    return child;
  }
}

/// A mixin that helps track widget lifecycle in debug mode
mixin PerformanceTrackingMixin<T extends StatefulWidget> on State<T> {
  String get widgetName => T.toString();

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      debugPrint('🟢 Initialized: $widgetName');
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      debugPrint('🔴 Disposed: $widgetName');
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (kDebugMode) {
      debugPrint('🔄 Updated: $widgetName');
    }
  }
}

/// A widget that prevents unnecessary rebuilds by using const constructor
class ConstWrapper extends StatelessWidget {
  const ConstWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

/// A widget that memoizes expensive computations
class MemoizedWidget extends StatelessWidget {
  const MemoizedWidget({
    super.key,
    required this.builder,
    required this.dependencies,
  });

  final Widget Function() builder;
  final List<Object?> dependencies;

  @override
  Widget build(BuildContext context) => _MemoizedWidgetState(builder: builder, dependencies: dependencies);
}

class _MemoizedWidgetState extends StatefulWidget {
  const _MemoizedWidgetState({
    required this.builder,
    required this.dependencies,
  });

  final Widget Function() builder;
  final List<Object?> dependencies;

  @override
  State<_MemoizedWidgetState> createState() => _MemoizedWidgetStateState();
}

class _MemoizedWidgetStateState extends State<_MemoizedWidgetState> {
  late Widget _cachedWidget;
  late List<Object?> _lastDependencies;

  @override
  void initState() {
    super.initState();
    _cachedWidget = widget.builder();
    _lastDependencies = List.from(widget.dependencies);
  }

  @override
  void didUpdateWidget(_MemoizedWidgetState oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if dependencies changed
    if (!_listEquals(_lastDependencies, widget.dependencies)) {
      _cachedWidget = widget.builder();
      _lastDependencies = List.from(widget.dependencies);

      if (kDebugMode) {
        debugPrint('🔄 MemoizedWidget rebuilt due to dependency change');
      }
    }
  }

  bool _listEquals(List<Object?> a, List<Object?> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) => _cachedWidget;
}
