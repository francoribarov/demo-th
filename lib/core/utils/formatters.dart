import 'dart:developer' as dev;

import 'package:intl/intl.dart';

/// Parses all integers from [s] (shared by [DurationParser] and [PlayersParser]).
List<int> _parseInts(String s) {
  return RegExp(r'\d+')
      .allMatches(s)
      .map((m) => int.tryParse(m.group(0) ?? ''))
      .whereType<int>()
      .toList();
}

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
      return '${_shortDateFormat.format(fromDate)} al '
          '${_shortDateFormat.format(toDate)}';
    } on Exception catch (e, st) {
      dev.log(
        'DateFormatter.formatRange: invalid input "$from" – "$to"',
        error: e,
        stackTrace: st,
      );
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
    } on Exception catch (e, st) {
      dev.log(
        'DateFormatter.parseIso: invalid input "$dateStr"',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }
}

/// Text normalization utilities (for search).
class TextNormalizer {
  TextNormalizer._();

  static final RegExp _aAccents = RegExp('[áàâäãāăąå]');
  static final RegExp _eAccents = RegExp('[éèêëēėę]');
  static final RegExp _iAccents = RegExp('[íìîïīį]');
  static final RegExp _oAccents = RegExp('[óòôöõōőø]');
  static final RegExp _uAccents = RegExp('[úùûüūů]');
  static const String _nAccent = 'ñ';

  /// Normalizes text for search comparison.
  /// Removes accents and converts to lowercase.
  static String normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll(_aAccents, 'a')
        .replaceAll(_eAccents, 'e')
        .replaceAll(_iAccents, 'i')
        .replaceAll(_oAccents, 'o')
        .replaceAll(_uAccents, 'u')
        .replaceAll(_nAccent, 'n');
  }
}

/// Duration parsing utilities.
class DurationParser {
  DurationParser._();

  /// Parses duration string (e.g., "60-90 min") to average minutes.
  static int? parseMinutes(String duration) {
    final numbers = _parseInts(duration);
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
    final numbers = _parseInts(players);
    if (numbers.isEmpty) return (min: null, max: null);
    if (numbers.length == 1) return (min: numbers.first, max: numbers.first);

    return (
      min: numbers.reduce((a, b) => a < b ? a : b),
      max: numbers.reduce((a, b) => a > b ? a : b),
    );
  }
}
