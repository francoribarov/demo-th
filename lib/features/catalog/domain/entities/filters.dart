// Public enums/props are self-explanatory within the filters domain.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'filters.freezed.dart';

/// Player range filter options
enum PlayersRangeOption { any, two, threeToFour, fiveToSix, sevenPlus }

extension PlayersRangeOptionX on PlayersRangeOption {
  String get label {
    switch (this) {
      case PlayersRangeOption.any:
        return 'Cualquiera';
      case PlayersRangeOption.two:
        return '2';
      case PlayersRangeOption.threeToFour:
        return '3–4';
      case PlayersRangeOption.fiveToSix:
        return '5–6';
      case PlayersRangeOption.sevenPlus:
        return '7+';
    }
  }

  String get chipLabel {
    switch (this) {
      case PlayersRangeOption.any:
        return '';
      case PlayersRangeOption.two:
        return '2 jugadores';
      case PlayersRangeOption.threeToFour:
        return '3–4 jugadores';
      case PlayersRangeOption.fiveToSix:
        return '5–6 jugadores';
      case PlayersRangeOption.sevenPlus:
        return '7+ jugadores';
    }
  }

  (int?, int?) get range {
    switch (this) {
      case PlayersRangeOption.any:
        return (null, null);
      case PlayersRangeOption.two:
        return (2, 2);
      case PlayersRangeOption.threeToFour:
        return (3, 4);
      case PlayersRangeOption.fiveToSix:
        return (5, 6);
      case PlayersRangeOption.sevenPlus:
        return (7, null);
    }
  }
}

/// Duration range filter options
enum DurationRangeOption {
  any,
  lte30,
  thirtyToSixty,
  sixtyToNinety,
  ninetyPlus,
}

extension DurationRangeOptionX on DurationRangeOption {
  String get label {
    switch (this) {
      case DurationRangeOption.any:
        return 'Cualquier duración';
      case DurationRangeOption.lte30:
        return '≤30 min';
      case DurationRangeOption.thirtyToSixty:
        return '30–60 min';
      case DurationRangeOption.sixtyToNinety:
        return '60–90 min';
      case DurationRangeOption.ninetyPlus:
        return '90+ min';
    }
  }

  String get chipLabel {
    switch (this) {
      case DurationRangeOption.any:
        return '';
      case DurationRangeOption.lte30:
        return 'Hasta 30 min';
      case DurationRangeOption.thirtyToSixty:
        return '30–60 min';
      case DurationRangeOption.sixtyToNinety:
        return '60–90 min';
      case DurationRangeOption.ninetyPlus:
        return '90+ min';
    }
  }

  (int?, int?) get range {
    switch (this) {
      case DurationRangeOption.any:
        return (null, null);
      case DurationRangeOption.lte30:
        return (null, 30);
      case DurationRangeOption.thirtyToSixty:
        return (30, 60);
      case DurationRangeOption.sixtyToNinety:
        return (60, 90);
      case DurationRangeOption.ninetyPlus:
        return (90, null);
    }
  }
}

/// Difficulty filter options
enum DifficultyOption { any, facil, media, dificil, experto }

extension DifficultyOptionX on DifficultyOption {
  String get label {
    switch (this) {
      case DifficultyOption.any:
        return 'Cualquiera';
      case DifficultyOption.facil:
        return 'Fácil';
      case DifficultyOption.media:
        return 'Media';
      case DifficultyOption.dificil:
        return 'Difícil';
      case DifficultyOption.experto:
        return 'Experto';
    }
  }

  String get chipLabel {
    switch (this) {
      case DifficultyOption.any:
        return '';
      case DifficultyOption.facil:
        return 'Fácil';
      case DifficultyOption.media:
        return 'Media';
      case DifficultyOption.dificil:
        return 'Difícil';
      case DifficultyOption.experto:
        return 'Experto';
    }
  }
}

/// Sort options
enum SortOption { availability, price, rating, duration }

extension SortOptionX on SortOption {
  String get label {
    switch (this) {
      case SortOption.availability:
        return 'Disponibilidad';
      case SortOption.price:
        return 'Precio más bajo';
      case SortOption.rating:
        return 'Mejor valoración';
      case SortOption.duration:
        return 'Partidas cortas';
    }
  }
}

/// Complete filters state
@freezed
abstract class FiltersState with _$FiltersState {
  const factory FiltersState({
    @Default(PlayersRangeOption.any) PlayersRangeOption playersRange,
    @Default(DurationRangeOption.any) DurationRangeOption durationRange,
    int? priceMin,
    int? priceMax,
    @Default(DifficultyOption.any) DifficultyOption difficulty,
    @Default([]) List<String> experienceTypes,
    @Default(false) bool onlyAvailableInDates,
    double? minRating,
  }) = _FiltersState;

  const FiltersState._();

  /// Check if any filter is active
  bool get hasActiveFilters =>
      playersRange != PlayersRangeOption.any ||
      durationRange != DurationRangeOption.any ||
      priceMin != null ||
      priceMax != null ||
      difficulty != DifficultyOption.any ||
      experienceTypes.isNotEmpty ||
      onlyAvailableInDates ||
      minRating != null;

  /// Count of active filters
  int get activeFiltersCount {
    var count = 0;
    if (playersRange != PlayersRangeOption.any) count++;
    if (durationRange != DurationRangeOption.any) count++;
    if (priceMin != null) count++;
    if (priceMax != null) count++;
    if (difficulty != DifficultyOption.any) count++;
    if (experienceTypes.isNotEmpty) count++;
    if (onlyAvailableInDates) count++;
    if (minRating != null) count++;
    return count;
  }
}

/// Experience type options
class ExperienceTypes {
  ExperienceTypes._();

  static const List<String> all = [
    'Familiar',
    'Fiesta',
    'Cooperativo',
    'Estrategia',
    'Abstracto',
  ];
}

/// Rating filter options
class RatingOptions {
  RatingOptions._();

  static const List<(double?, String)> all = [
    (null, 'Cualquiera'),
    (4.0, '≥ 4.0'),
    (4.5, '≥ 4.5'),
  ];
}
