import 'package:flutter/material.dart';

/// Shared date picker behavior for all app flows.
class AppDatePicker {
  AppDatePicker._();

  static const Locale _defaultLocale = Locale('es', 'UY');
  static const int _defaultWindowDays = 365;

  /// Returns the current day without time information.
  static DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Returns a default max selectable day from a [from] date.
  static DateTime defaultLastDate({DateTime? from}) {
    final start = _dateOnly(from ?? today());
    return start.add(const Duration(days: _defaultWindowDays));
  }

  /// Shows a single-date picker with app-standard defaults.
  static Future<DateTime?> pickDate({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) async {
    final normalizedFirst = _dateOnly(firstDate ?? today());
    final normalizedLast = _dateOnly(
      lastDate ?? defaultLastDate(from: normalizedFirst),
    );
    final safeInitial = _clampDate(
      candidate: _dateOnly(initialDate ?? normalizedFirst),
      firstDate: normalizedFirst,
      lastDate: normalizedLast,
    );

    return showDatePicker(
      context: context,
      initialDate: safeInitial,
      firstDate: normalizedFirst,
      lastDate: normalizedLast,
      locale: _defaultLocale,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
    );
  }

  /// Shows a range-date picker with app-standard defaults.
  static Future<DateTimeRange?> pickDateRange({
    required BuildContext context,
    DateTimeRange? initialDateRange,
    DateTime? firstDate,
    DateTime? lastDate,
    bool Function(DateTime day, DateTime? start, DateTime? end)?
        selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    String? saveText,
  }) async {
    final normalizedFirst = _dateOnly(firstDate ?? today());
    final normalizedLast = _dateOnly(
      lastDate ?? defaultLastDate(from: normalizedFirst),
    );
    final safeInitialRange = _normalizeInitialRange(
      initialDateRange: initialDateRange,
      firstDate: normalizedFirst,
      lastDate: normalizedLast,
    );

    return showDateRangePicker(
      context: context,
      initialDateRange: safeInitialRange,
      firstDate: normalizedFirst,
      lastDate: normalizedLast,
      locale: _defaultLocale,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      saveText: saveText,
    );
  }

  static DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime _clampDate({
    required DateTime candidate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    if (candidate.isBefore(firstDate)) return firstDate;
    if (candidate.isAfter(lastDate)) return lastDate;
    return candidate;
  }

  static DateTimeRange? _normalizeInitialRange({
    required DateTimeRange? initialDateRange,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    if (initialDateRange == null) return null;

    final start = _dateOnly(initialDateRange.start);
    final end = _dateOnly(initialDateRange.end);
    if (end.isBefore(start)) return null;
    if (start.isBefore(firstDate) || end.isAfter(lastDate)) return null;

    return DateTimeRange(start: start, end: end);
  }
}
