import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';

/// Extension to map [PlayersRangeOption] to API parameter
extension PlayersRangeOptionToApi on PlayersRangeOption {
  String? toApiParam() {
    return switch (this) {
      PlayersRangeOption.any => null,
      PlayersRangeOption.two => '2',
      PlayersRangeOption.threeToFour => '3-4',
      PlayersRangeOption.fiveToSix => '5-6',
      PlayersRangeOption.sevenPlus => '7+',
    };
  }
}

/// Extension to map [DurationRangeOption] to API parameter
extension DurationRangeOptionToApi on DurationRangeOption {
  String? toApiParam() {
    return switch (this) {
      DurationRangeOption.any => null,
      DurationRangeOption.lte30 => 'lte30',
      DurationRangeOption.thirtyToSixty => '30-60',
      DurationRangeOption.sixtyToNinety => '60-90',
      DurationRangeOption.ninetyPlus => '90+',
    };
  }
}

/// Extension to map [DifficultyOption] to API parameter
extension DifficultyOptionToApi on DifficultyOption {
  String? toApiParam() {
    return switch (this) {
      DifficultyOption.any => null,
      DifficultyOption.facil => label,
      DifficultyOption.media => label,
      DifficultyOption.dificil => label,
      DifficultyOption.experto => label,
    };
  }
}

/// Extension to map [SortOption] to API parameter
extension SortOptionToApi on SortOption {
  String toApiParam() {
    return switch (this) {
      SortOption.availability => 'availability',
      SortOption.price => 'price',
      SortOption.rating => 'rating',
      SortOption.duration => 'duration',
    };
  }
}

/// Extension to map [FiltersState] category to API parameter
extension FiltersStateToApi on FiltersState {
  String? get categoryApiParam {
    return experienceTypes.isNotEmpty ? experienceTypes.first : null;
  }
}
