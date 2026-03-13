import 'package:intl/intl.dart';

/// Currency and number formatting utilities.
class CurrencyFormatter {
  CurrencyFormatter._();

  static final _uyuFormat = NumberFormat.currency(
    locale: 'es_UY',
    symbol: r'$',
    decimalDigits: 0,
  );

  /// Formats a number as UYU currency (e.g., "$45").
  static String formatUYU(num value) {
    return _uyuFormat.format(value);
  }

  /// Formats a price with "/día" suffix.
  static String formatPricePerDay(num value) {
    return '${formatUYU(value)}/día';
  }
}

/// Date formatting utilities.
class DateFormatter {
  DateFormatter._();

  static final _shortDateFormat = DateFormat('d MMM', 'es_UY');
  static final _fullDateFormat = DateFormat("EEEE d 'de' MMMM", 'es_UY');
  static final _isoFormat = DateFormat('yyyy-MM-dd');

  /// Formats a date range (e.g., "4 nov al 12 nov").
  static String formatRange(String from, String to) {
    try {
      final fromDate = DateTime.parse(from);
      final toDate = DateTime.parse(to);
      return '${_shortDateFormat.format(fromDate)} al ${_shortDateFormat.format(toDate)}';
    } on Exception catch (_) {
      return '$from - $to';
    }
  }

  /// Formats a date for display (e.g., "lunes 4 de noviembre").
  static String formatFullDate(DateTime date) {
    return _fullDateFormat.format(date).toLowerCase();
  }

  /// Formats a date as ISO string (e.g., "2025-11-04").
  static String toIsoString(DateTime date) {
    return _isoFormat.format(date);
  }

  /// Parses an ISO date string.
  static DateTime? parseIso(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr);
    } on Exception catch (_) {
      return null;
    }
  }
}

/// Text normalization utilities (for search).
class TextNormalizer {
  TextNormalizer._();

  static const _accentMap = {
    'á': 'a',
    'à': 'a',
    'â': 'a',
    'ä': 'a',
    'é': 'e',
    'è': 'e',
    'ê': 'e',
    'ë': 'e',
    'í': 'i',
    'ì': 'i',
    'î': 'i',
    'ï': 'i',
    'ó': 'o',
    'ò': 'o',
    'ô': 'o',
    'ö': 'o',
    'ú': 'u',
    'ù': 'u',
    'û': 'u',
    'ü': 'u',
    'ñ': 'n',
  };

  /// Normalizes text for search comparison.
  /// Removes accents and converts to lowercase.
  static String normalize(String value) {
    var result = value.toLowerCase();
    for (final e in _accentMap.entries) {
      result = result.replaceAll(e.key, e.value);
    }
    return result;
  }
}

List<int> _extractIntegers(String s) {
  final numbers = <int>[];
  var i = 0;
  while (i < s.length) {
    if (s[i].compareTo('0') >= 0 && s[i].compareTo('9') <= 0) {
      var j = i;
      while (j < s.length && s[j].compareTo('0') >= 0 && s[j].compareTo('9') <= 0) {
        j++;
      }
      final n = int.tryParse(s.substring(i, j));
      if (n != null) numbers.add(n);
      i = j;
    } else {
      i++;
    }
  }
  return numbers;
}

/// Duration parsing utilities.
class DurationParser {
  DurationParser._();

  /// Parses duration string (e.g., "60-90 min") to average minutes.
  static int? parseMinutes(String duration) {
    final numbers = _extractIntegers(duration);

    if (numbers.isEmpty) return null;
    if (numbers.length == 1) return numbers.first;

    // Return average for ranges
    return (numbers.reduce((a, b) => a + b) / numbers.length).round();
  }
}

/// Player count parsing utilities.
class PlayersParser {
  PlayersParser._();

  /// Parses players string (e.g., "2-4 jugadores") to min/max range.
  static ({int? min, int? max}) parseRange(String players) {
    final numbers = _extractIntegers(players);

    if (numbers.isEmpty) return (min: null, max: null);
    if (numbers.length == 1) return (min: numbers.first, max: numbers.first);

    return (
      min: numbers.reduce((a, b) => a < b ? a : b),
      max: numbers.reduce((a, b) => a > b ? a : b),
    );
  }
}
