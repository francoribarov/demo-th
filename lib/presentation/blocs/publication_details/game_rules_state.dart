part of 'game_rules_bloc.dart';

@freezed
/// State for [GameRulesBloc].
abstract class GameRulesState with _$GameRulesState {
  /// Creates a [GameRulesState].
  const factory GameRulesState({
    @Default(false) bool isLoading,
    Game? game,
    String? errorMessage,
  }) = _GameRulesState;
}
