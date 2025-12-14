import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama_taxi/core/services/logging_service.dart';

/// Performance monitoring utility for tracking widget build times and operations
class PerformanceMonitor {
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();

  final Map<String, Stopwatch> _stopwatches = {};

  /// Start timing an operation
  void startTimer(String operationName) {
    if (!kDebugMode) return;

    _stopwatches[operationName] = Stopwatch()..start();
  }

  /// Stop timing an operation and log the result
  void stopTimer(String operationName) {
    if (!kDebugMode) return;

    final stopwatch = _stopwatches[operationName];
    if (stopwatch != null) {
      stopwatch.stop();
      logger.logPerformance(operationName, stopwatch.elapsed);
      _stopwatches.remove(operationName);
    }
  }

  /// Time a synchronous operation
  T timeOperation<T>(String operationName, T Function() operation) {
    if (!kDebugMode) return operation();

    final stopwatch = Stopwatch()..start();
    try {
      final result = operation();
      stopwatch.stop();
      logger.logPerformance(operationName, stopwatch.elapsed);
      return result;
    } catch (e) {
      stopwatch.stop();
      logger.logPerformance('$operationName (failed)', stopwatch.elapsed);
      rethrow;
    }
  }

  /// Time an asynchronous operation
  Future<T> timeAsyncOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    if (!kDebugMode) return operation();

    final stopwatch = Stopwatch()..start();
    try {
      final result = await operation();
      stopwatch.stop();
      logger.logPerformance(operationName, stopwatch.elapsed);
      return result;
    } catch (e) {
      stopwatch.stop();
      logger.logPerformance('$operationName (failed)', stopwatch.elapsed);
      rethrow;
    }
  }
}

/// Widget that monitors its build performance
class PerformanceMonitorWidget extends StatelessWidget {
  const PerformanceMonitorWidget({
    super.key,
    required this.name,
    required this.child,
    this.enabled = kDebugMode,
  });

  final String name;
  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return _BuildTimeTracker(name: name, child: child);
  }
}

/// Internal widget to track build times
class _BuildTimeTracker extends StatelessWidget {
  const _BuildTimeTracker({required this.name, required this.child});

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final stopwatch = Stopwatch()..start();

    // Build the child widget
    final builtChild = child;

    stopwatch.stop();

    // Log build time if it's significant
    if (stopwatch.elapsedMilliseconds > 16) {
      // More than one frame at 60fps
      logger.logPerformance('Widget build: $name', stopwatch.elapsed);
    }

    return builtChild;
  }
}

/// Mixin for performance monitoring in widgets
mixin PerformanceMonitorMixin {
  final PerformanceMonitor _performanceMonitor = PerformanceMonitor();

  /// Start timing an operation
  void startTimer(String operationName) {
    _performanceMonitor.startTimer(operationName);
  }

  /// Stop timing an operation
  void stopTimer(String operationName) {
    _performanceMonitor.stopTimer(operationName);
  }

  /// Time a synchronous operation
  T timeOperation<T>(String operationName, T Function() operation) => _performanceMonitor.timeOperation(operationName, operation);

  /// Time an asynchronous operation
  Future<T> timeAsyncOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) => _performanceMonitor.timeAsyncOperation(operationName, operation);
}

/// Global performance monitor instance
final performanceMonitor = PerformanceMonitor();
