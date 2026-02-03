part of 'game_rules_bloc.dart';

@freezed

/// Events for [GameRulesBloc].
abstract class GameRulesEvent with _$GameRulesEvent {
  /// Starts loading the game rules.
  const factory GameRulesEvent.started({required String gameId}) = _Started;
}
