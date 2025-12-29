// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_rules_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GameRulesEvent {
  String get gameId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({required TResult Function(String gameId) started}) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({TResult? Function(String gameId)? started}) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({TResult Function(String gameId)? started, required TResult orElse()}) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({required TResult Function(_Started value) started}) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({TResult? Function(_Started value)? started}) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({TResult Function(_Started value)? started, required TResult orElse()}) =>
      throw _privateConstructorUsedError;

  /// Create a copy of GameRulesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameRulesEventCopyWith<GameRulesEvent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRulesEventCopyWith<$Res> {
  factory $GameRulesEventCopyWith(GameRulesEvent value, $Res Function(GameRulesEvent) then) =
      _$GameRulesEventCopyWithImpl<$Res, GameRulesEvent>;
  @useResult
  $Res call({String gameId});
}

/// @nodoc
class _$GameRulesEventCopyWithImpl<$Res, $Val extends GameRulesEvent> implements $GameRulesEventCopyWith<$Res> {
  _$GameRulesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameRulesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? gameId = null}) {
    return _then(
      _value.copyWith(
            gameId: null == gameId
                ? _value.gameId
                : gameId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> implements $GameRulesEventCopyWith<$Res> {
  factory _$$StartedImplCopyWith(_$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String gameId});
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res> extends _$GameRulesEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(_$StartedImpl _value, $Res Function(_$StartedImpl) _then) : super(_value, _then);

  /// Create a copy of GameRulesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? gameId = null}) {
    return _then(
      _$StartedImpl(
        gameId: null == gameId
            ? _value.gameId
            : gameId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl({required this.gameId});

  @override
  final String gameId;

  @override
  String toString() {
    return 'GameRulesEvent.started(gameId: $gameId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartedImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameId);

  /// Create a copy of GameRulesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith => __$$StartedImplCopyWithImpl<_$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({required TResult Function(String gameId) started}) {
    return started(gameId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({TResult? Function(String gameId)? started}) {
    return started?.call(gameId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({TResult Function(String gameId)? started, required TResult orElse()}) {
    if (started != null) {
      return started(gameId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({required TResult Function(_Started value) started}) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({TResult? Function(_Started value)? started}) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({TResult Function(_Started value)? started, required TResult orElse()}) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements GameRulesEvent {
  const factory _Started({required final String gameId}) = _$StartedImpl;

  @override
  String get gameId;

  /// Create a copy of GameRulesEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GameRulesState {
  bool get isLoading => throw _privateConstructorUsedError;
  Game? get game => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of GameRulesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameRulesStateCopyWith<GameRulesState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRulesStateCopyWith<$Res> {
  factory $GameRulesStateCopyWith(GameRulesState value, $Res Function(GameRulesState) then) =
      _$GameRulesStateCopyWithImpl<$Res, GameRulesState>;
  @useResult
  $Res call({bool isLoading, Game? game, String? errorMessage});

  $GameCopyWith<$Res>? get game;
}

/// @nodoc
class _$GameRulesStateCopyWithImpl<$Res, $Val extends GameRulesState> implements $GameRulesStateCopyWith<$Res> {
  _$GameRulesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameRulesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? game = freezed, Object? errorMessage = freezed}) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            game: freezed == game
                ? _value.game
                : game // ignore: cast_nullable_to_non_nullable
                      as Game?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of GameRulesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameCopyWith<$Res>? get game {
    if (_value.game == null) {
      return null;
    }

    return $GameCopyWith<$Res>(_value.game!, (value) {
      return _then(_value.copyWith(game: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameRulesStateImplCopyWith<$Res> implements $GameRulesStateCopyWith<$Res> {
  factory _$$GameRulesStateImplCopyWith(_$GameRulesStateImpl value, $Res Function(_$GameRulesStateImpl) then) =
      __$$GameRulesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, Game? game, String? errorMessage});

  @override
  $GameCopyWith<$Res>? get game;
}

/// @nodoc
class __$$GameRulesStateImplCopyWithImpl<$Res> extends _$GameRulesStateCopyWithImpl<$Res, _$GameRulesStateImpl>
    implements _$$GameRulesStateImplCopyWith<$Res> {
  __$$GameRulesStateImplCopyWithImpl(_$GameRulesStateImpl _value, $Res Function(_$GameRulesStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of GameRulesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? game = freezed, Object? errorMessage = freezed}) {
    return _then(
      _$GameRulesStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        game: freezed == game
            ? _value.game
            : game // ignore: cast_nullable_to_non_nullable
                  as Game?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$GameRulesStateImpl implements _GameRulesState {
  const _$GameRulesStateImpl({this.isLoading = false, this.game, this.errorMessage});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Game? game;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'GameRulesState(isLoading: $isLoading, game: $game, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameRulesStateImpl &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.game, game) || other.game == game) &&
            (identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, game, errorMessage);

  /// Create a copy of GameRulesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameRulesStateImplCopyWith<_$GameRulesStateImpl> get copyWith =>
      __$$GameRulesStateImplCopyWithImpl<_$GameRulesStateImpl>(this, _$identity);
}

abstract class _GameRulesState implements GameRulesState {
  const factory _GameRulesState({final bool isLoading, final Game? game, final String? errorMessage}) =
      _$GameRulesStateImpl;

  @override
  bool get isLoading;
  @override
  Game? get game;
  @override
  String? get errorMessage;

  /// Create a copy of GameRulesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameRulesStateImplCopyWith<_$GameRulesStateImpl> get copyWith => throw _privateConstructorUsedError;
}
