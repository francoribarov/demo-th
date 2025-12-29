// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_reviews_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GameReviewsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId) started,
    required TResult Function(int? value) filterRatingChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId)? started,
    TResult? Function(int? value)? filterRatingChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId)? started,
    TResult Function(int? value)? filterRatingChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterRatingChanged value) filterRatingChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterRatingChanged value)? filterRatingChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterRatingChanged value)? filterRatingChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameReviewsEventCopyWith<$Res> {
  factory $GameReviewsEventCopyWith(GameReviewsEvent value, $Res Function(GameReviewsEvent) then) =
      _$GameReviewsEventCopyWithImpl<$Res, GameReviewsEvent>;
}

/// @nodoc
class _$GameReviewsEventCopyWithImpl<$Res, $Val extends GameReviewsEvent> implements $GameReviewsEventCopyWith<$Res> {
  _$GameReviewsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(_$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String gameId});
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res> extends _$GameReviewsEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(_$StartedImpl _value, $Res Function(_$StartedImpl) _then) : super(_value, _then);

  /// Create a copy of GameReviewsEvent
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
    return 'GameReviewsEvent.started(gameId: $gameId)';
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

  /// Create a copy of GameReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith => __$$StartedImplCopyWithImpl<_$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId) started,
    required TResult Function(int? value) filterRatingChanged,
  }) {
    return started(gameId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId)? started,
    TResult? Function(int? value)? filterRatingChanged,
  }) {
    return started?.call(gameId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId)? started,
    TResult Function(int? value)? filterRatingChanged,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(gameId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterRatingChanged value) filterRatingChanged,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterRatingChanged value)? filterRatingChanged,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterRatingChanged value)? filterRatingChanged,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements GameReviewsEvent {
  const factory _Started({required final String gameId}) = _$StartedImpl;

  String get gameId;

  /// Create a copy of GameReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterRatingChangedImplCopyWith<$Res> {
  factory _$$FilterRatingChangedImplCopyWith(
    _$FilterRatingChangedImpl value,
    $Res Function(_$FilterRatingChangedImpl) then,
  ) = __$$FilterRatingChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? value});
}

/// @nodoc
class __$$FilterRatingChangedImplCopyWithImpl<$Res>
    extends _$GameReviewsEventCopyWithImpl<$Res, _$FilterRatingChangedImpl>
    implements _$$FilterRatingChangedImplCopyWith<$Res> {
  __$$FilterRatingChangedImplCopyWithImpl(
    _$FilterRatingChangedImpl _value,
    $Res Function(_$FilterRatingChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = freezed}) {
    return _then(
      _$FilterRatingChangedImpl(
        freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$FilterRatingChangedImpl implements _FilterRatingChanged {
  const _$FilterRatingChangedImpl(this.value);

  @override
  final int? value;

  @override
  String toString() {
    return 'GameReviewsEvent.filterRatingChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterRatingChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of GameReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterRatingChangedImplCopyWith<_$FilterRatingChangedImpl> get copyWith =>
      __$$FilterRatingChangedImplCopyWithImpl<_$FilterRatingChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId) started,
    required TResult Function(int? value) filterRatingChanged,
  }) {
    return filterRatingChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId)? started,
    TResult? Function(int? value)? filterRatingChanged,
  }) {
    return filterRatingChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId)? started,
    TResult Function(int? value)? filterRatingChanged,
    required TResult orElse(),
  }) {
    if (filterRatingChanged != null) {
      return filterRatingChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterRatingChanged value) filterRatingChanged,
  }) {
    return filterRatingChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterRatingChanged value)? filterRatingChanged,
  }) {
    return filterRatingChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterRatingChanged value)? filterRatingChanged,
    required TResult orElse(),
  }) {
    if (filterRatingChanged != null) {
      return filterRatingChanged(this);
    }
    return orElse();
  }
}

abstract class _FilterRatingChanged implements GameReviewsEvent {
  const factory _FilterRatingChanged(final int? value) = _$FilterRatingChangedImpl;

  int? get value;

  /// Create a copy of GameReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterRatingChangedImplCopyWith<_$FilterRatingChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GameReviewsState {
  bool get isLoading => throw _privateConstructorUsedError;
  Game? get game => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int? get filterRating => throw _privateConstructorUsedError;

  /// Create a copy of GameReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameReviewsStateCopyWith<GameReviewsState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameReviewsStateCopyWith<$Res> {
  factory $GameReviewsStateCopyWith(GameReviewsState value, $Res Function(GameReviewsState) then) =
      _$GameReviewsStateCopyWithImpl<$Res, GameReviewsState>;
  @useResult
  $Res call({bool isLoading, Game? game, String? errorMessage, int? filterRating});

  $GameCopyWith<$Res>? get game;
}

/// @nodoc
class _$GameReviewsStateCopyWithImpl<$Res, $Val extends GameReviewsState> implements $GameReviewsStateCopyWith<$Res> {
  _$GameReviewsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? game = freezed,
    Object? errorMessage = freezed,
    Object? filterRating = freezed,
  }) {
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
            filterRating: freezed == filterRating
                ? _value.filterRating
                : filterRating // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of GameReviewsState
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
abstract class _$$GameReviewsStateImplCopyWith<$Res> implements $GameReviewsStateCopyWith<$Res> {
  factory _$$GameReviewsStateImplCopyWith(_$GameReviewsStateImpl value, $Res Function(_$GameReviewsStateImpl) then) =
      __$$GameReviewsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, Game? game, String? errorMessage, int? filterRating});

  @override
  $GameCopyWith<$Res>? get game;
}

/// @nodoc
class __$$GameReviewsStateImplCopyWithImpl<$Res> extends _$GameReviewsStateCopyWithImpl<$Res, _$GameReviewsStateImpl>
    implements _$$GameReviewsStateImplCopyWith<$Res> {
  __$$GameReviewsStateImplCopyWithImpl(_$GameReviewsStateImpl _value, $Res Function(_$GameReviewsStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of GameReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? game = freezed,
    Object? errorMessage = freezed,
    Object? filterRating = freezed,
  }) {
    return _then(
      _$GameReviewsStateImpl(
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
        filterRating: freezed == filterRating
            ? _value.filterRating
            : filterRating // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$GameReviewsStateImpl extends _GameReviewsState {
  const _$GameReviewsStateImpl({this.isLoading = false, this.game, this.errorMessage, this.filterRating}) : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Game? game;
  @override
  final String? errorMessage;
  @override
  final int? filterRating;

  @override
  String toString() {
    return 'GameReviewsState(isLoading: $isLoading, game: $game, errorMessage: $errorMessage, filterRating: $filterRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameReviewsStateImpl &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.game, game) || other.game == game) &&
            (identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage) &&
            (identical(other.filterRating, filterRating) || other.filterRating == filterRating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, game, errorMessage, filterRating);

  /// Create a copy of GameReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameReviewsStateImplCopyWith<_$GameReviewsStateImpl> get copyWith =>
      __$$GameReviewsStateImplCopyWithImpl<_$GameReviewsStateImpl>(this, _$identity);
}

abstract class _GameReviewsState extends GameReviewsState {
  const factory _GameReviewsState({
    final bool isLoading,
    final Game? game,
    final String? errorMessage,
    final int? filterRating,
  }) = _$GameReviewsStateImpl;
  const _GameReviewsState._() : super._();

  @override
  bool get isLoading;
  @override
  Game? get game;
  @override
  String? get errorMessage;
  @override
  int? get filterRating;

  /// Create a copy of GameReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameReviewsStateImplCopyWith<_$GameReviewsStateImpl> get copyWith => throw _privateConstructorUsedError;
}
