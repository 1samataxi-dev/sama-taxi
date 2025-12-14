import 'package:intl/intl.dart';

/// Comprehensive formatting helper functions
///
/// This class provides static methods for formatting numbers, currency,
/// file sizes, and other common data types with localization support.
class FormatHelpers {
  FormatHelpers._(); // Private constructor to prevent instantiation

  // ============================================================================
  // NUMBER FORMATTING
  // ============================================================================

  /// Formats number with thousand separators
  static String formatNumber(num number, {int? decimalPlaces, String? locale}) {
    final formatter = NumberFormat(
      '#,##0${decimalPlaces != null ? '.${'0' * decimalPlaces}' : ''}',
      locale,
    );
    return formatter.format(number);
  }

  /// Formats number as percentage
  static String formatPercentage(
    double value, {
    int decimalPlaces = 1,
    String? locale,
  }) {
    final formatter = NumberFormat.percentPattern(locale);
    formatter.minimumFractionDigits = decimalPlaces;
    formatter.maximumFractionDigits = decimalPlaces;
    return formatter.format(value);
  }

  /// Formats number in compact form (1K, 1M, 1B)
  static String formatCompactNumber(num number, {String? locale}) {
    final formatter = NumberFormat.compact(locale: locale);
    return formatter.format(number);
  }

  /// Formats number with ordinal suffix (1st, 2nd, 3rd)
  static String formatOrdinal(int number) {
    if (number >= 11 && number <= 13) {
      return '${number}th';
    }

    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  // ============================================================================
  // CURRENCY FORMATTING
  // ============================================================================

  /// Formats currency with symbol
  static String formatCurrency(
    double amount, {
    String currencyCode = 'USD',
    String? locale,
    int? decimalPlaces,
    String? symbol,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      name: currencyCode,
      symbol: symbol,
      decimalDigits: decimalPlaces,
    );
    return formatter.format(amount);
  }

  /// Formats currency in compact form ($1K, $1M)
  static String formatCompactCurrency(
    double amount, {
    String currencyCode = 'USD',
    String? locale,
    String? symbol,
  }) {
    final formatter = NumberFormat.compactCurrency(
      locale: locale,
      name: currencyCode,
      symbol: symbol,
    );
    return formatter.format(amount);
  }

  /// Formats currency without symbol
  static String formatCurrencyValue(
    double amount, {
    int decimalPlaces = 2,
    String? locale,
  }) {
    final formatter = NumberFormat('#,##0.${'0' * decimalPlaces}', locale);
    return formatter.format(amount);
  }

  // ============================================================================
  // FILE SIZE FORMATTING
  // ============================================================================

  /// Formats file size in bytes to human readable format
  static String formatFileSize(
    int bytes, {
    int decimalPlaces = 1,
    bool useBinaryUnits = false,
  }) {
    if (bytes <= 0) return '0 B';

    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    const binarySuffixes = ['B', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB'];

    final base = useBinaryUnits ? 1024 : 1000;
    final units = useBinaryUnits ? binarySuffixes : suffixes;

    final i = (bytes.bitLength - 1) ~/ (useBinaryUnits ? 10 : 10);
    final index = i.clamp(0, units.length - 1);

    final size = bytes / (base * index);
    final formattedSize = size.toStringAsFixed(decimalPlaces);

    return '$formattedSize ${units[index]}';
  }

  // ============================================================================
  // DURATION FORMATTING
  // ============================================================================

  /// Formats duration to human readable format
  static String formatDuration(
    Duration duration, {
    bool showMilliseconds = false,
    bool compact = false,
  }) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    final milliseconds = duration.inMilliseconds % 1000;

    final parts = <String>[];

    if (days > 0) {
      parts.add(compact ? '${days}d' : '$days ${days == 1 ? 'day' : 'days'}');
    }

    if (hours > 0) {
      parts.add(
        compact ? '${hours}h' : '$hours ${hours == 1 ? 'hour' : 'hours'}',
      );
    }

    if (minutes > 0) {
      parts.add(
        compact
            ? '${minutes}m'
            : '$minutes ${minutes == 1 ? 'minute' : 'minutes'}',
      );
    }

    if (seconds > 0 || parts.isEmpty) {
      parts.add(
        compact
            ? '${seconds}s'
            : '$seconds ${seconds == 1 ? 'second' : 'seconds'}',
      );
    }

    if (showMilliseconds && milliseconds > 0) {
      parts.add(compact ? '${milliseconds}ms' : '$milliseconds ms');
    }

    return parts.join(compact ? ' ' : ', ');
  }

  /// Formats duration as time (HH:MM:SS)
  static String formatDurationAsTime(
    Duration duration, {
    bool showHours = true,
    bool showMilliseconds = false,
  }) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    final milliseconds = duration.inMilliseconds % 1000;

    final hoursStr = hours.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');
    final millisecondsStr = milliseconds.toString().padLeft(3, '0');

    if (showHours) {
      final timeStr = '$hoursStr:$minutesStr:$secondsStr';
      return showMilliseconds ? '$timeStr.$millisecondsStr' : timeStr;
    } else {
      final timeStr = '$minutesStr:$secondsStr';
      return showMilliseconds ? '$timeStr.$millisecondsStr' : timeStr;
    }
  }

  // ============================================================================
  // TEXT FORMATTING
  // ============================================================================

  /// Capitalizes first letter of each word
  static String toTitleCase(String text) {
    if (text.isEmpty) return text;

    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  /// Capitalizes first letter of text
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Converts text to camelCase
  static String toCamelCase(String text) {
    if (text.isEmpty) return text;

    final words = text.split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return text;

    final first = words.first.toLowerCase();
    final rest = words.skip(1).map((word) => capitalize(word.toLowerCase()));

    return first + rest.join();
  }

  /// Converts text to snake_case
  static String toSnakeCase(String text) => text
        .replaceAllMapped(
          RegExp('[A-Z]'),
          (match) => '_${match.group(0)!.toLowerCase()}',
        )
        .replaceAll(RegExp(r'[\s-]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '')
        .toLowerCase();

  /// Converts text to kebab-case
  static String toKebabCase(String text) => toSnakeCase(text).replaceAll('_', '-');

  /// Truncates text with ellipsis
  static String truncate(
    String text,
    int maxLength, {
    String ellipsis = '...',
  }) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength - ellipsis.length) + ellipsis;
  }

  /// Truncates text at word boundary
  static String truncateAtWord(
    String text,
    int maxLength, {
    String ellipsis = '...',
  }) {
    if (text.length <= maxLength) return text;

    final truncated = text.substring(0, maxLength - ellipsis.length);
    final lastSpace = truncated.lastIndexOf(' ');

    if (lastSpace > 0) {
      return truncated.substring(0, lastSpace) + ellipsis;
    }

    return truncated + ellipsis;
  }

  // ============================================================================
  // PHONE NUMBER FORMATTING
  // ============================================================================

  /// Formats phone number with standard formatting
  static String formatPhoneNumber(
    String phoneNumber, {
    String countryCode = '+1',
    String format = '(###) ###-####',
  }) {
    // Remove all non-digit characters
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) return phoneNumber;

    // Apply formatting
    var formatted = format;
    var digitIndex = 0;

    for (var i = 0; i < formatted.length && digitIndex < digits.length; i++) {
      if (formatted[i] == '#') {
        formatted = formatted.replaceFirst('#', digits[digitIndex]);
        digitIndex++;
      }
    }

    return formatted;
  }

  // ============================================================================
  // CREDIT CARD FORMATTING
  // ============================================================================

  /// Formats credit card number with spaces
  static String formatCreditCard(String cardNumber) {
    final digits = cardNumber.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }

    return buffer.toString();
  }

  /// Masks credit card number (shows only last 4 digits)
  static String maskCreditCard(
    String cardNumber, {
    String maskChar = '*',
    int visibleDigits = 4,
  }) {
    final digits = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (digits.length <= visibleDigits) return digits;

    final masked = maskChar * (digits.length - visibleDigits);
    final visible = digits.substring(digits.length - visibleDigits);

    return formatCreditCard(masked + visible);
  }

  // ============================================================================
  // LIST FORMATTING
  // ============================================================================

  /// Formats list of items as comma-separated string
  static String formatList(
    List<String> items, {
    String separator = ', ',
    String? lastSeparator,
  }) {
    if (items.isEmpty) return '';
    if (items.length == 1) return items.first;

    final lastSep = lastSeparator ?? separator;
    final allButLast = items.take(items.length - 1).join(separator);

    return '$allButLast$lastSep${items.last}';
  }

  /// Formats list with "and" conjunction
  static String formatListWithAnd(List<String> items) => formatList(items, lastSeparator: ' and ');

  /// Formats list with "or" conjunction
  static String formatListWithOr(List<String> items) => formatList(items, lastSeparator: ' or ');

  // ============================================================================
  // VALIDATION HELPERS
  // ============================================================================

  /// Checks if string is numeric
  static bool isNumeric(String str) => double.tryParse(str) != null;

  /// Checks if string is integer
  static bool isInteger(String str) => int.tryParse(str) != null;

  /// Checks if string is valid email format
  static bool isValidEmail(String email) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  /// Checks if string is valid URL format
  static bool isValidUrl(String url) => RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    ).hasMatch(url);
}
