// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GameDetailsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId) started,
    required TResult Function() toggleWishlist,
    required TResult Function(String? value) checkStartDateChanged,
    required TResult Function(String? value) checkEndDateChanged,
    required TResult Function() checkAvailabilityPressed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId)? started,
    TResult? Function()? toggleWishlist,
    TResult? Function(String? value)? checkStartDateChanged,
    TResult? Function(String? value)? checkEndDateChanged,
    TResult? Function()? checkAvailabilityPressed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId)? started,
    TResult Function()? toggleWishlist,
    TResult Function(String? value)? checkStartDateChanged,
    TResult Function(String? value)? checkEndDateChanged,
    TResult Function()? checkAvailabilityPressed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_ToggleWishlist value) toggleWishlist,
    required TResult Function(_CheckStartDateChanged value) checkStartDateChanged,
    required TResult Function(_CheckEndDateChanged value) checkEndDateChanged,
    required TResult Function(_CheckAvailabilityPressed value) checkAvailabilityPressed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ToggleWishlist value)? toggleWishlist,
    TResult? Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult? Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult? Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ToggleWishlist value)? toggleWishlist,
    TResult Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameDetailsEventCopyWith<$Res> {
  factory $GameDetailsEventCopyWith(GameDetailsEvent value, $Res Function(GameDetailsEvent) then) =
      _$GameDetailsEventCopyWithImpl<$Res, GameDetailsEvent>;
}

/// @nodoc
class _$GameDetailsEventCopyWithImpl<$Res, $Val extends GameDetailsEvent> implements $GameDetailsEventCopyWith<$Res> {
  _$GameDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameDetailsEvent
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
class __$$StartedImplCopyWithImpl<$Res> extends _$GameDetailsEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(_$StartedImpl _value, $Res Function(_$StartedImpl) _then) : super(_value, _then);

  /// Create a copy of GameDetailsEvent
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
    return 'GameDetailsEvent.started(gameId: $gameId)';
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

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith => __$$StartedImplCopyWithImpl<_$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId) started,
    required TResult Function() toggleWishlist,
    required TResult Function(String? value) checkStartDateChanged,
    required TResult Function(String? value) checkEndDateChanged,
    required TResult Function() checkAvailabilityPressed,
  }) {
    return started(gameId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId)? started,
    TResult? Function()? toggleWishlist,
    TResult? Function(String? value)? checkStartDateChanged,
    TResult? Function(String? value)? checkEndDateChanged,
    TResult? Function()? checkAvailabilityPressed,
  }) {
    return started?.call(gameId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId)? started,
    TResult Function()? toggleWishlist,
    TResult Function(String? value)? checkStartDateChanged,
    TResult Function(String? value)? checkEndDateChanged,
    TResult Function()? checkAvailabilityPressed,
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
    required TResult Function(_ToggleWishlist value) toggleWishlist,
    required TResult Function(_CheckStartDateChanged value) checkStartDateChanged,
    required TResult Function(_CheckEndDateChanged value) checkEndDateChanged,
    required TResult Function(_CheckAvailabilityPressed value) checkAvailabilityPressed,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ToggleWishlist value)? toggleWishlist,
    TResult? Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult? Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult? Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ToggleWishlist value)? toggleWishlist,
    TResult Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements GameDetailsEvent {
  const factory _Started({required final String gameId}) = _$StartedImpl;

  String get gameId;

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleWishlistImplCopyWith<$Res> {
  factory _$$ToggleWishlistImplCopyWith(_$ToggleWishlistImpl value, $Res Function(_$ToggleWishlistImpl) then) =
      __$$ToggleWishlistImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleWishlistImplCopyWithImpl<$Res> extends _$GameDetailsEventCopyWithImpl<$Res, _$ToggleWishlistImpl>
    implements _$$ToggleWishlistImplCopyWith<$Res> {
  __$$ToggleWishlistImplCopyWithImpl(_$ToggleWishlistImpl _value, $Res Function(_$ToggleWishlistImpl) _then)
    : super(_value, _then);

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ToggleWishlistImpl implements _ToggleWishlist {
  const _$ToggleWishlistImpl();

  @override
  String toString() {
    return 'GameDetailsEvent.toggleWishlist()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$ToggleWishlistImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId) started,
    required TResult Function() toggleWishlist,
    required TResult Function(String? value) checkStartDateChanged,
    required TResult Function(String? value) checkEndDateChanged,
    required TResult Function() checkAvailabilityPressed,
  }) {
    return toggleWishlist();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId)? started,
    TResult? Function()? toggleWishlist,
    TResult? Function(String? value)? checkStartDateChanged,
    TResult? Function(String? value)? checkEndDateChanged,
    TResult? Function()? checkAvailabilityPressed,
  }) {
    return toggleWishlist?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId)? started,
    TResult Function()? toggleWishlist,
    TResult Function(String? value)? checkStartDateChanged,
    TResult Function(String? value)? checkEndDateChanged,
    TResult Function()? checkAvailabilityPressed,
    required TResult orElse(),
  }) {
    if (toggleWishlist != null) {
      return toggleWishlist();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_ToggleWishlist value) toggleWishlist,
    required TResult Function(_CheckStartDateChanged value) checkStartDateChanged,
    required TResult Function(_CheckEndDateChanged value) checkEndDateChanged,
    required TResult Function(_CheckAvailabilityPressed value) checkAvailabilityPressed,
  }) {
    return toggleWishlist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ToggleWishlist value)? toggleWishlist,
    TResult? Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult? Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult? Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
  }) {
    return toggleWishlist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ToggleWishlist value)? toggleWishlist,
    TResult Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
    required TResult orElse(),
  }) {
    if (toggleWishlist != null) {
      return toggleWishlist(this);
    }
    return orElse();
  }
}

abstract class _ToggleWishlist implements GameDetailsEvent {
  const factory _ToggleWishlist() = _$ToggleWishlistImpl;
}

/// @nodoc
abstract class _$$CheckStartDateChangedImplCopyWith<$Res> {
  factory _$$CheckStartDateChangedImplCopyWith(
    _$CheckStartDateChangedImpl value,
    $Res Function(_$CheckStartDateChangedImpl) then,
  ) = __$$CheckStartDateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? value});
}

/// @nodoc
class __$$CheckStartDateChangedImplCopyWithImpl<$Res>
    extends _$GameDetailsEventCopyWithImpl<$Res, _$CheckStartDateChangedImpl>
    implements _$$CheckStartDateChangedImplCopyWith<$Res> {
  __$$CheckStartDateChangedImplCopyWithImpl(
    _$CheckStartDateChangedImpl _value,
    $Res Function(_$CheckStartDateChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = freezed}) {
    return _then(
      _$CheckStartDateChangedImpl(
        freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CheckStartDateChangedImpl implements _CheckStartDateChanged {
  const _$CheckStartDateChangedImpl(this.value);

  @override
  final String? value;

  @override
  String toString() {
    return 'GameDetailsEvent.checkStartDateChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckStartDateChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckStartDateChangedImplCopyWith<_$CheckStartDateChangedImpl> get copyWith =>
      __$$CheckStartDateChangedImplCopyWithImpl<_$CheckStartDateChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId) started,
    required TResult Function() toggleWishlist,
    required TResult Function(String? value) checkStartDateChanged,
    required TResult Function(String? value) checkEndDateChanged,
    required TResult Function() checkAvailabilityPressed,
  }) {
    return checkStartDateChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId)? started,
    TResult? Function()? toggleWishlist,
    TResult? Function(String? value)? checkStartDateChanged,
    TResult? Function(String? value)? checkEndDateChanged,
    TResult? Function()? checkAvailabilityPressed,
  }) {
    return checkStartDateChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId)? started,
    TResult Function()? toggleWishlist,
    TResult Function(String? value)? checkStartDateChanged,
    TResult Function(String? value)? checkEndDateChanged,
    TResult Function()? checkAvailabilityPressed,
    required TResult orElse(),
  }) {
    if (checkStartDateChanged != null) {
      return checkStartDateChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_ToggleWishlist value) toggleWishlist,
    required TResult Function(_CheckStartDateChanged value) checkStartDateChanged,
    required TResult Function(_CheckEndDateChanged value) checkEndDateChanged,
    required TResult Function(_CheckAvailabilityPressed value) checkAvailabilityPressed,
  }) {
    return checkStartDateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ToggleWishlist value)? toggleWishlist,
    TResult? Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult? Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult? Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
  }) {
    return checkStartDateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ToggleWishlist value)? toggleWishlist,
    TResult Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
    required TResult orElse(),
  }) {
    if (checkStartDateChanged != null) {
      return checkStartDateChanged(this);
    }
    return orElse();
  }
}

abstract class _CheckStartDateChanged implements GameDetailsEvent {
  const factory _CheckStartDateChanged(final String? value) = _$CheckStartDateChangedImpl;

  String? get value;

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckStartDateChangedImplCopyWith<_$CheckStartDateChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckEndDateChangedImplCopyWith<$Res> {
  factory _$$CheckEndDateChangedImplCopyWith(
    _$CheckEndDateChangedImpl value,
    $Res Function(_$CheckEndDateChangedImpl) then,
  ) = __$$CheckEndDateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? value});
}

/// @nodoc
class __$$CheckEndDateChangedImplCopyWithImpl<$Res>
    extends _$GameDetailsEventCopyWithImpl<$Res, _$CheckEndDateChangedImpl>
    implements _$$CheckEndDateChangedImplCopyWith<$Res> {
  __$$CheckEndDateChangedImplCopyWithImpl(
    _$CheckEndDateChangedImpl _value,
    $Res Function(_$CheckEndDateChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = freezed}) {
    return _then(
      _$CheckEndDateChangedImpl(
        freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CheckEndDateChangedImpl implements _CheckEndDateChanged {
  const _$CheckEndDateChangedImpl(this.value);

  @override
  final String? value;

  @override
  String toString() {
    return 'GameDetailsEvent.checkEndDateChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckEndDateChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckEndDateChangedImplCopyWith<_$CheckEndDateChangedImpl> get copyWith =>
      __$$CheckEndDateChangedImplCopyWithImpl<_$CheckEndDateChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId) started,
    required TResult Function() toggleWishlist,
    required TResult Function(String? value) checkStartDateChanged,
    required TResult Function(String? value) checkEndDateChanged,
    required TResult Function() checkAvailabilityPressed,
  }) {
    return checkEndDateChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId)? started,
    TResult? Function()? toggleWishlist,
    TResult? Function(String? value)? checkStartDateChanged,
    TResult? Function(String? value)? checkEndDateChanged,
    TResult? Function()? checkAvailabilityPressed,
  }) {
    return checkEndDateChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId)? started,
    TResult Function()? toggleWishlist,
    TResult Function(String? value)? checkStartDateChanged,
    TResult Function(String? value)? checkEndDateChanged,
    TResult Function()? checkAvailabilityPressed,
    required TResult orElse(),
  }) {
    if (checkEndDateChanged != null) {
      return checkEndDateChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_ToggleWishlist value) toggleWishlist,
    required TResult Function(_CheckStartDateChanged value) checkStartDateChanged,
    required TResult Function(_CheckEndDateChanged value) checkEndDateChanged,
    required TResult Function(_CheckAvailabilityPressed value) checkAvailabilityPressed,
  }) {
    return checkEndDateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ToggleWishlist value)? toggleWishlist,
    TResult? Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult? Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult? Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
  }) {
    return checkEndDateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ToggleWishlist value)? toggleWishlist,
    TResult Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
    required TResult orElse(),
  }) {
    if (checkEndDateChanged != null) {
      return checkEndDateChanged(this);
    }
    return orElse();
  }
}

abstract class _CheckEndDateChanged implements GameDetailsEvent {
  const factory _CheckEndDateChanged(final String? value) = _$CheckEndDateChangedImpl;

  String? get value;

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckEndDateChangedImplCopyWith<_$CheckEndDateChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckAvailabilityPressedImplCopyWith<$Res> {
  factory _$$CheckAvailabilityPressedImplCopyWith(
    _$CheckAvailabilityPressedImpl value,
    $Res Function(_$CheckAvailabilityPressedImpl) then,
  ) = __$$CheckAvailabilityPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckAvailabilityPressedImplCopyWithImpl<$Res>
    extends _$GameDetailsEventCopyWithImpl<$Res, _$CheckAvailabilityPressedImpl>
    implements _$$CheckAvailabilityPressedImplCopyWith<$Res> {
  __$$CheckAvailabilityPressedImplCopyWithImpl(
    _$CheckAvailabilityPressedImpl _value,
    $Res Function(_$CheckAvailabilityPressedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckAvailabilityPressedImpl implements _CheckAvailabilityPressed {
  const _$CheckAvailabilityPressedImpl();

  @override
  String toString() {
    return 'GameDetailsEvent.checkAvailabilityPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$CheckAvailabilityPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId) started,
    required TResult Function() toggleWishlist,
    required TResult Function(String? value) checkStartDateChanged,
    required TResult Function(String? value) checkEndDateChanged,
    required TResult Function() checkAvailabilityPressed,
  }) {
    return checkAvailabilityPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId)? started,
    TResult? Function()? toggleWishlist,
    TResult? Function(String? value)? checkStartDateChanged,
    TResult? Function(String? value)? checkEndDateChanged,
    TResult? Function()? checkAvailabilityPressed,
  }) {
    return checkAvailabilityPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId)? started,
    TResult Function()? toggleWishlist,
    TResult Function(String? value)? checkStartDateChanged,
    TResult Function(String? value)? checkEndDateChanged,
    TResult Function()? checkAvailabilityPressed,
    required TResult orElse(),
  }) {
    if (checkAvailabilityPressed != null) {
      return checkAvailabilityPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_ToggleWishlist value) toggleWishlist,
    required TResult Function(_CheckStartDateChanged value) checkStartDateChanged,
    required TResult Function(_CheckEndDateChanged value) checkEndDateChanged,
    required TResult Function(_CheckAvailabilityPressed value) checkAvailabilityPressed,
  }) {
    return checkAvailabilityPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ToggleWishlist value)? toggleWishlist,
    TResult? Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult? Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult? Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
  }) {
    return checkAvailabilityPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ToggleWishlist value)? toggleWishlist,
    TResult Function(_CheckStartDateChanged value)? checkStartDateChanged,
    TResult Function(_CheckEndDateChanged value)? checkEndDateChanged,
    TResult Function(_CheckAvailabilityPressed value)? checkAvailabilityPressed,
    required TResult orElse(),
  }) {
    if (checkAvailabilityPressed != null) {
      return checkAvailabilityPressed(this);
    }
    return orElse();
  }
}

abstract class _CheckAvailabilityPressed implements GameDetailsEvent {
  const factory _CheckAvailabilityPressed() = _$CheckAvailabilityPressedImpl;
}

/// @nodoc
mixin _$GameDetailsState {
  bool get isLoading => throw _privateConstructorUsedError;
  Game? get game => throw _privateConstructorUsedError;
  List<Game> get recommendations => throw _privateConstructorUsedError;
  bool get isWishlisted => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError; // Availability check form
  String? get checkStartDate => throw _privateConstructorUsedError;
  String? get checkEndDate => throw _privateConstructorUsedError;
  bool? get availabilityResult => throw _privateConstructorUsedError;

  /// Create a copy of GameDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameDetailsStateCopyWith<GameDetailsState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameDetailsStateCopyWith<$Res> {
  factory $GameDetailsStateCopyWith(GameDetailsState value, $Res Function(GameDetailsState) then) =
      _$GameDetailsStateCopyWithImpl<$Res, GameDetailsState>;
  @useResult
  $Res call({
    bool isLoading,
    Game? game,
    List<Game> recommendations,
    bool isWishlisted,
    String? errorMessage,
    String? checkStartDate,
    String? checkEndDate,
    bool? availabilityResult,
  });

  $GameCopyWith<$Res>? get game;
}

/// @nodoc
class _$GameDetailsStateCopyWithImpl<$Res, $Val extends GameDetailsState> implements $GameDetailsStateCopyWith<$Res> {
  _$GameDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? game = freezed,
    Object? recommendations = null,
    Object? isWishlisted = null,
    Object? errorMessage = freezed,
    Object? checkStartDate = freezed,
    Object? checkEndDate = freezed,
    Object? availabilityResult = freezed,
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
            recommendations: null == recommendations
                ? _value.recommendations
                : recommendations // ignore: cast_nullable_to_non_nullable
                      as List<Game>,
            isWishlisted: null == isWishlisted
                ? _value.isWishlisted
                : isWishlisted // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            checkStartDate: freezed == checkStartDate
                ? _value.checkStartDate
                : checkStartDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            checkEndDate: freezed == checkEndDate
                ? _value.checkEndDate
                : checkEndDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            availabilityResult: freezed == availabilityResult
                ? _value.availabilityResult
                : availabilityResult // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }

  /// Create a copy of GameDetailsState
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
abstract class _$$GameDetailsStateImplCopyWith<$Res> implements $GameDetailsStateCopyWith<$Res> {
  factory _$$GameDetailsStateImplCopyWith(_$GameDetailsStateImpl value, $Res Function(_$GameDetailsStateImpl) then) =
      __$$GameDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    Game? game,
    List<Game> recommendations,
    bool isWishlisted,
    String? errorMessage,
    String? checkStartDate,
    String? checkEndDate,
    bool? availabilityResult,
  });

  @override
  $GameCopyWith<$Res>? get game;
}

/// @nodoc
class __$$GameDetailsStateImplCopyWithImpl<$Res> extends _$GameDetailsStateCopyWithImpl<$Res, _$GameDetailsStateImpl>
    implements _$$GameDetailsStateImplCopyWith<$Res> {
  __$$GameDetailsStateImplCopyWithImpl(_$GameDetailsStateImpl _value, $Res Function(_$GameDetailsStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of GameDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? game = freezed,
    Object? recommendations = null,
    Object? isWishlisted = null,
    Object? errorMessage = freezed,
    Object? checkStartDate = freezed,
    Object? checkEndDate = freezed,
    Object? availabilityResult = freezed,
  }) {
    return _then(
      _$GameDetailsStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        game: freezed == game
            ? _value.game
            : game // ignore: cast_nullable_to_non_nullable
                  as Game?,
        recommendations: null == recommendations
            ? _value._recommendations
            : recommendations // ignore: cast_nullable_to_non_nullable
                  as List<Game>,
        isWishlisted: null == isWishlisted
            ? _value.isWishlisted
            : isWishlisted // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        checkStartDate: freezed == checkStartDate
            ? _value.checkStartDate
            : checkStartDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        checkEndDate: freezed == checkEndDate
            ? _value.checkEndDate
            : checkEndDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        availabilityResult: freezed == availabilityResult
            ? _value.availabilityResult
            : availabilityResult // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

class _$GameDetailsStateImpl implements _GameDetailsState {
  const _$GameDetailsStateImpl({
    this.isLoading = false,
    this.game,
    final List<Game> recommendations = const [],
    this.isWishlisted = false,
    this.errorMessage,
    this.checkStartDate,
    this.checkEndDate,
    this.availabilityResult,
  }) : _recommendations = recommendations;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Game? game;
  final List<Game> _recommendations;
  @override
  @JsonKey()
  List<Game> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  @JsonKey()
  final bool isWishlisted;
  @override
  final String? errorMessage;
  // Availability check form
  @override
  final String? checkStartDate;
  @override
  final String? checkEndDate;
  @override
  final bool? availabilityResult;

  @override
  String toString() {
    return 'GameDetailsState(isLoading: $isLoading, game: $game, recommendations: $recommendations, isWishlisted: $isWishlisted, errorMessage: $errorMessage, checkStartDate: $checkStartDate, checkEndDate: $checkEndDate, availabilityResult: $availabilityResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameDetailsStateImpl &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.game, game) || other.game == game) &&
            const DeepCollectionEquality().equals(other._recommendations, _recommendations) &&
            (identical(other.isWishlisted, isWishlisted) || other.isWishlisted == isWishlisted) &&
            (identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage) &&
            (identical(other.checkStartDate, checkStartDate) || other.checkStartDate == checkStartDate) &&
            (identical(other.checkEndDate, checkEndDate) || other.checkEndDate == checkEndDate) &&
            (identical(other.availabilityResult, availabilityResult) ||
                other.availabilityResult == availabilityResult));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    game,
    const DeepCollectionEquality().hash(_recommendations),
    isWishlisted,
    errorMessage,
    checkStartDate,
    checkEndDate,
    availabilityResult,
  );

  /// Create a copy of GameDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameDetailsStateImplCopyWith<_$GameDetailsStateImpl> get copyWith =>
      __$$GameDetailsStateImplCopyWithImpl<_$GameDetailsStateImpl>(this, _$identity);
}

abstract class _GameDetailsState implements GameDetailsState {
  const factory _GameDetailsState({
    final bool isLoading,
    final Game? game,
    final List<Game> recommendations,
    final bool isWishlisted,
    final String? errorMessage,
    final String? checkStartDate,
    final String? checkEndDate,
    final bool? availabilityResult,
  }) = _$GameDetailsStateImpl;

  @override
  bool get isLoading;
  @override
  Game? get game;
  @override
  List<Game> get recommendations;
  @override
  bool get isWishlisted;
  @override
  String? get errorMessage; // Availability check form
  @override
  String? get checkStartDate;
  @override
  String? get checkEndDate;
  @override
  bool? get availabilityResult;

  /// Create a copy of GameDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameDetailsStateImplCopyWith<_$GameDetailsStateImpl> get copyWith => throw _privateConstructorUsedError;
}
