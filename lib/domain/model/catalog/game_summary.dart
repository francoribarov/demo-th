import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_summary.freezed.dart';

@freezed
sealed class GameSummary with _$GameSummary {
  const factory GameSummary({
    required String id,
    required String title,
    required int price,
    @Default([]) List<String> images,
    String? ownerId,
  }) = _GameSummary;
}
