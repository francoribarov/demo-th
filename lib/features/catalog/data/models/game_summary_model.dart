import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game_summary.dart';

part 'game_summary_model.freezed.dart';
part 'game_summary_model.g.dart';

@freezed
sealed class GameSummaryModel
    with _$GameSummaryModel
    implements BaseDtoResponse<GameSummary> {
  const factory GameSummaryModel({
    required String id,
    required String title,
    required int price,
    @Default([]) List<GameImageModel> images,
    @JsonKey(name: 'owner_id') String? ownerId,
  }) = _GameSummaryModel;

  const GameSummaryModel._();

  factory GameSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$GameSummaryModelFromJson(json);

  @override
  GameSummary toDomainModel() {
    return GameSummary(
      id: id,
      title: title,
      images: images.map((e) => e.url).toList(),
      price: price,
      ownerId: ownerId,
    );
  }
}
