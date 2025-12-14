import 'package:intl/intl.dart';

/// Comprehensive date and time helper functions
///
/// This class provides static methods for common date operations,
/// formatting, parsing, and calculations with localization support.
class DateHelpers {
  DateHelpers._(); // Private constructor to prevent instantiation

  // ============================================================================
  // FORMATTING HELPERS
  // ============================================================================

  /// Formats date to readable string
  static String formatDate(
    DateTime date, {
    String pattern = 'MMM dd, yyyy',
    String? locale,
  }) {
    final formatter = DateFormat(pattern, locale);
    return formatter.format(date);
  }

  /// Formats time to readable string
  static String formatTime(
    DateTime time, {
    String pattern = 'HH:mm',
    String? locale,
  }) {
    final formatter = DateFormat(pattern, locale);
    return formatter.format(time);
  }

  /// Formats date and time to readable string
  static String formatDateTime(
    DateTime dateTime, {
    String pattern = 'MMM dd, yyyy HH:mm',
    String? locale,
  }) {
    final formatter = DateFormat(pattern, locale);
    return formatter.format(dateTime);
  }

  /// Formats date relative to now (e.g., "2 days ago", "in 3 hours")
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.isNegative) {
      // Future date
      final futureDifference = dateTime.difference(now);
      return _formatFutureDifference(futureDifference);
    } else {
      // Past date
      return _formatPastDifference(difference);
    }
  }

  static String _formatPastDifference(Duration difference) {
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? '1 hour ago'
          : '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 minute ago'
          : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  static String _formatFutureDifference(Duration difference) {
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? 'in 1 year' : 'in $years years';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? 'in 1 month' : 'in $months months';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? 'in 1 day'
          : 'in ${difference.inDays} days';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? 'in 1 hour'
          : 'in ${difference.inHours} hours';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? 'in 1 minute'
          : 'in ${difference.inMinutes} minutes';
    } else {
      return 'Now';
    }
  }

  // ============================================================================
  // PARSING HELPERS
  // ============================================================================

  /// Parses date string to DateTime
  static DateTime? parseDate(
    String dateString, {
    String pattern = 'yyyy-MM-dd',
    String? locale,
  }) {
    try {
      final formatter = DateFormat(pattern, locale);
      return formatter.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Parses multiple date formats
  static DateTime? parseDateFlexible(String dateString) {
    final patterns = [
      'yyyy-MM-dd',
      'dd/MM/yyyy',
      'MM/dd/yyyy',
      'dd-MM-yyyy',
      'MM-dd-yyyy',
      'yyyy/MM/dd',
      'MMM dd, yyyy',
      'dd MMM yyyy',
      'MMMM dd, yyyy',
      'dd MMMM yyyy',
    ];

    for (final pattern in patterns) {
      final result = parseDate(dateString, pattern: pattern);
      if (result != null) return result;
    }

    return null;
  }

  // ============================================================================
  // DATE CALCULATIONS
  // ============================================================================

  /// Adds days to a date
  static DateTime addDays(DateTime date, int days) => date.add(Duration(days: days));

  /// Adds months to a date
  static DateTime addMonths(DateTime date, int months) {
    final newMonth = date.month + months;
    final newYear = date.year + (newMonth - 1) ~/ 12;
    final adjustedMonth = ((newMonth - 1) % 12) + 1;

    // Handle day overflow (e.g., Jan 31 + 1 month = Feb 28/29)
    final lastDayOfMonth = DateTime(newYear, adjustedMonth + 1, 0).day;
    final newDay = date.day > lastDayOfMonth ? lastDayOfMonth : date.day;

    return DateTime(
      newYear,
      adjustedMonth,
      newDay,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }

  /// Adds years to a date
  static DateTime addYears(DateTime date, int years) => addMonths(date, years * 12);

  /// Gets the difference between two dates in days
  static int daysBetween(DateTime start, DateTime end) {
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);
    return endDate.difference(startDate).inDays;
  }

  /// Gets the difference between two dates in months
  static int monthsBetween(DateTime start, DateTime end) => (end.year - start.year) * 12 + end.month - start.month;

  /// Gets the difference between two dates in years
  static int yearsBetween(DateTime start, DateTime end) {
    var years = end.year - start.year;
    if (end.month < start.month ||
        (end.month == start.month && end.day < start.day)) {
      years--;
    }
    return years;
  }

  // ============================================================================
  // DATE UTILITIES
  // ============================================================================

  /// Checks if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Checks if a date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Checks if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Checks if a date is in the current week
  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Checks if a date is in the current month
  static bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Checks if a date is in the current year
  static bool isThisYear(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year;
  }

  /// Checks if a year is a leap year
  static bool isLeapYear(int year) => (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

  /// Gets the number of days in a month
  static int daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  /// Gets the start of day (00:00:00)
  static DateTime startOfDay(DateTime date) => DateTime(date.year, date.month, date.day);

  /// Gets the end of day (23:59:59.999)
  static DateTime endOfDay(DateTime date) => DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

  /// Gets the start of week (Monday 00:00:00)
  static DateTime startOfWeek(DateTime date) {
    final daysFromMonday = date.weekday - 1;
    return startOfDay(date.subtract(Duration(days: daysFromMonday)));
  }

  /// Gets the end of week (Sunday 23:59:59.999)
  static DateTime endOfWeek(DateTime date) {
    final daysToSunday = 7 - date.weekday;
    return endOfDay(date.add(Duration(days: daysToSunday)));
  }

  /// Gets the start of month (1st day 00:00:00)
  static DateTime startOfMonth(DateTime date) => DateTime(date.year, date.month);

  /// Gets the end of month (last day 23:59:59.999)
  static DateTime endOfMonth(DateTime date) {
    final lastDay = daysInMonth(date.year, date.month);
    return DateTime(date.year, date.month, lastDay, 23, 59, 59, 999);
  }

  /// Gets the start of year (Jan 1st 00:00:00)
  static DateTime startOfYear(DateTime date) => DateTime(date.year);

  /// Gets the end of year (Dec 31st 23:59:59.999)
  static DateTime endOfYear(DateTime date) => DateTime(date.year, 12, 31, 23, 59, 59, 999);

  // ============================================================================
  // AGE CALCULATIONS
  // ============================================================================

  /// Calculates age from birth date
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    var age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  /// Calculates detailed age (years, months, days)
  static AgeDetails calculateDetailedAge(DateTime birthDate) {
    final now = DateTime.now();

    var years = now.year - birthDate.year;
    var months = now.month - birthDate.month;
    var days = now.day - birthDate.day;

    if (days < 0) {
      months--;
      days += daysInMonth(now.year, now.month - 1);
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    return AgeDetails(years: years, months: months, days: days);
  }

  // ============================================================================
  // BUSINESS DATE CALCULATIONS
  // ============================================================================

  /// Checks if a date is a weekend
  static bool isWeekend(DateTime date) => date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

  /// Checks if a date is a weekday
  static bool isWeekday(DateTime date) => !isWeekend(date);

  /// Adds business days (excluding weekends)
  static DateTime addBusinessDays(DateTime date, int businessDays) {
    var result = date;
    var daysAdded = 0;

    while (daysAdded < businessDays) {
      result = result.add(const Duration(days: 1));
      if (isWeekday(result)) {
        daysAdded++;
      }
    }

    return result;
  }

  /// Counts business days between two dates
  static int businessDaysBetween(DateTime start, DateTime end) {
    if (start.isAfter(end)) return 0;

    var businessDays = 0;
    var current = start;

    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      if (isWeekday(current)) {
        businessDays++;
      }
      current = current.add(const Duration(days: 1));
    }

    return businessDays;
  }

  // ============================================================================
  // TIME ZONE HELPERS
  // ============================================================================

  /// Converts DateTime to UTC
  static DateTime toUtc(DateTime dateTime) => dateTime.toUtc();

  /// Converts DateTime to local time
  static DateTime toLocal(DateTime dateTime) => dateTime.toLocal();

  /// Gets current timestamp in milliseconds
  static int currentTimestamp() => DateTime.now().millisecondsSinceEpoch;

  /// Creates DateTime from timestamp
  static DateTime fromTimestamp(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp);

  // ============================================================================
  // VALIDATION HELPERS
  // ============================================================================

  /// Validates if a date is within a range
  static bool isDateInRange(
    DateTime date,
    DateTime startDate,
    DateTime endDate,
  ) => date.isAfter(startDate.subtract(const Duration(days: 1))) &&
        date.isBefore(endDate.add(const Duration(days: 1)));

  /// Validates if a date is in the future
  static bool isFutureDate(DateTime date) => date.isAfter(DateTime.now());

  /// Validates if a date is in the past
  static bool isPastDate(DateTime date) => date.isBefore(DateTime.now());
}

/// Class to hold detailed age information
class AgeDetails {
  const AgeDetails({
    required this.years,
    required this.months,
    required this.days,
  });

  final int years;
  final int months;
  final int days;

  @override
  String toString() {
    final parts = <String>[];

    if (years > 0) {
      parts.add('$years ${years == 1 ? 'year' : 'years'}');
    }

    if (months > 0) {
      parts.add('$months ${months == 1 ? 'month' : 'months'}');
    }

    if (days > 0) {
      parts.add('$days ${days == 1 ? 'day' : 'days'}');
    }

    if (parts.isEmpty) {
      return 'Today';
    }

    return parts.join(', ');
  }
}
