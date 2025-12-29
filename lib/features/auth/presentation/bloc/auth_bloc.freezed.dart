// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) = _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent> implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(_$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(_$StartedImpl _value, $Res Function(_$StartedImpl) _then) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'AuthEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements AuthEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$LoginEmailChangedImplCopyWith<$Res> {
  factory _$$LoginEmailChangedImplCopyWith(_$LoginEmailChangedImpl value, $Res Function(_$LoginEmailChangedImpl) then) =
      __$$LoginEmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$LoginEmailChangedImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$LoginEmailChangedImpl>
    implements _$$LoginEmailChangedImplCopyWith<$Res> {
  __$$LoginEmailChangedImplCopyWithImpl(_$LoginEmailChangedImpl _value, $Res Function(_$LoginEmailChangedImpl) _then)
    : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$LoginEmailChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoginEmailChangedImpl implements _LoginEmailChanged {
  const _$LoginEmailChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'AuthEvent.loginEmailChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginEmailChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginEmailChangedImplCopyWith<_$LoginEmailChangedImpl> get copyWith =>
      __$$LoginEmailChangedImplCopyWithImpl<_$LoginEmailChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return loginEmailChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return loginEmailChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (loginEmailChanged != null) {
      return loginEmailChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return loginEmailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return loginEmailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (loginEmailChanged != null) {
      return loginEmailChanged(this);
    }
    return orElse();
  }
}

abstract class _LoginEmailChanged implements AuthEvent {
  const factory _LoginEmailChanged(final String value) = _$LoginEmailChangedImpl;

  String get value;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginEmailChangedImplCopyWith<_$LoginEmailChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginPasswordChangedImplCopyWith<$Res> {
  factory _$$LoginPasswordChangedImplCopyWith(
    _$LoginPasswordChangedImpl value,
    $Res Function(_$LoginPasswordChangedImpl) then,
  ) = __$$LoginPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$LoginPasswordChangedImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$LoginPasswordChangedImpl>
    implements _$$LoginPasswordChangedImplCopyWith<$Res> {
  __$$LoginPasswordChangedImplCopyWithImpl(
    _$LoginPasswordChangedImpl _value,
    $Res Function(_$LoginPasswordChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$LoginPasswordChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoginPasswordChangedImpl implements _LoginPasswordChanged {
  const _$LoginPasswordChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'AuthEvent.loginPasswordChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPasswordChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginPasswordChangedImplCopyWith<_$LoginPasswordChangedImpl> get copyWith =>
      __$$LoginPasswordChangedImplCopyWithImpl<_$LoginPasswordChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return loginPasswordChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return loginPasswordChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (loginPasswordChanged != null) {
      return loginPasswordChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return loginPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return loginPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (loginPasswordChanged != null) {
      return loginPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class _LoginPasswordChanged implements AuthEvent {
  const factory _LoginPasswordChanged(final String value) = _$LoginPasswordChangedImpl;

  String get value;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginPasswordChangedImplCopyWith<_$LoginPasswordChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginSubmittedImplCopyWith<$Res> {
  factory _$$LoginSubmittedImplCopyWith(_$LoginSubmittedImpl value, $Res Function(_$LoginSubmittedImpl) then) =
      __$$LoginSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSubmittedImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$LoginSubmittedImpl>
    implements _$$LoginSubmittedImplCopyWith<$Res> {
  __$$LoginSubmittedImplCopyWithImpl(_$LoginSubmittedImpl _value, $Res Function(_$LoginSubmittedImpl) _then)
    : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginSubmittedImpl implements _LoginSubmitted {
  const _$LoginSubmittedImpl();

  @override
  String toString() {
    return 'AuthEvent.loginSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$LoginSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return loginSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return loginSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (loginSubmitted != null) {
      return loginSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return loginSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return loginSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (loginSubmitted != null) {
      return loginSubmitted(this);
    }
    return orElse();
  }
}

abstract class _LoginSubmitted implements AuthEvent {
  const factory _LoginSubmitted() = _$LoginSubmittedImpl;
}

/// @nodoc
abstract class _$$RegisterEmailChangedImplCopyWith<$Res> {
  factory _$$RegisterEmailChangedImplCopyWith(
    _$RegisterEmailChangedImpl value,
    $Res Function(_$RegisterEmailChangedImpl) then,
  ) = __$$RegisterEmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$RegisterEmailChangedImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$RegisterEmailChangedImpl>
    implements _$$RegisterEmailChangedImplCopyWith<$Res> {
  __$$RegisterEmailChangedImplCopyWithImpl(
    _$RegisterEmailChangedImpl _value,
    $Res Function(_$RegisterEmailChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$RegisterEmailChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RegisterEmailChangedImpl implements _RegisterEmailChanged {
  const _$RegisterEmailChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'AuthEvent.registerEmailChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterEmailChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterEmailChangedImplCopyWith<_$RegisterEmailChangedImpl> get copyWith =>
      __$$RegisterEmailChangedImplCopyWithImpl<_$RegisterEmailChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return registerEmailChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return registerEmailChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (registerEmailChanged != null) {
      return registerEmailChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return registerEmailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return registerEmailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (registerEmailChanged != null) {
      return registerEmailChanged(this);
    }
    return orElse();
  }
}

abstract class _RegisterEmailChanged implements AuthEvent {
  const factory _RegisterEmailChanged(final String value) = _$RegisterEmailChangedImpl;

  String get value;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterEmailChangedImplCopyWith<_$RegisterEmailChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterPasswordChangedImplCopyWith<$Res> {
  factory _$$RegisterPasswordChangedImplCopyWith(
    _$RegisterPasswordChangedImpl value,
    $Res Function(_$RegisterPasswordChangedImpl) then,
  ) = __$$RegisterPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$RegisterPasswordChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisterPasswordChangedImpl>
    implements _$$RegisterPasswordChangedImplCopyWith<$Res> {
  __$$RegisterPasswordChangedImplCopyWithImpl(
    _$RegisterPasswordChangedImpl _value,
    $Res Function(_$RegisterPasswordChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$RegisterPasswordChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RegisterPasswordChangedImpl implements _RegisterPasswordChanged {
  const _$RegisterPasswordChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'AuthEvent.registerPasswordChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterPasswordChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterPasswordChangedImplCopyWith<_$RegisterPasswordChangedImpl> get copyWith =>
      __$$RegisterPasswordChangedImplCopyWithImpl<_$RegisterPasswordChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return registerPasswordChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return registerPasswordChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (registerPasswordChanged != null) {
      return registerPasswordChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return registerPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return registerPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (registerPasswordChanged != null) {
      return registerPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class _RegisterPasswordChanged implements AuthEvent {
  const factory _RegisterPasswordChanged(final String value) = _$RegisterPasswordChangedImpl;

  String get value;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterPasswordChangedImplCopyWith<_$RegisterPasswordChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterNameChangedImplCopyWith<$Res> {
  factory _$$RegisterNameChangedImplCopyWith(
    _$RegisterNameChangedImpl value,
    $Res Function(_$RegisterNameChangedImpl) then,
  ) = __$$RegisterNameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$RegisterNameChangedImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$RegisterNameChangedImpl>
    implements _$$RegisterNameChangedImplCopyWith<$Res> {
  __$$RegisterNameChangedImplCopyWithImpl(
    _$RegisterNameChangedImpl _value,
    $Res Function(_$RegisterNameChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$RegisterNameChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RegisterNameChangedImpl implements _RegisterNameChanged {
  const _$RegisterNameChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'AuthEvent.registerNameChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterNameChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterNameChangedImplCopyWith<_$RegisterNameChangedImpl> get copyWith =>
      __$$RegisterNameChangedImplCopyWithImpl<_$RegisterNameChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return registerNameChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return registerNameChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (registerNameChanged != null) {
      return registerNameChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return registerNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return registerNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (registerNameChanged != null) {
      return registerNameChanged(this);
    }
    return orElse();
  }
}

abstract class _RegisterNameChanged implements AuthEvent {
  const factory _RegisterNameChanged(final String value) = _$RegisterNameChangedImpl;

  String get value;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterNameChangedImplCopyWith<_$RegisterNameChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterLocationChangedImplCopyWith<$Res> {
  factory _$$RegisterLocationChangedImplCopyWith(
    _$RegisterLocationChangedImpl value,
    $Res Function(_$RegisterLocationChangedImpl) then,
  ) = __$$RegisterLocationChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$RegisterLocationChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisterLocationChangedImpl>
    implements _$$RegisterLocationChangedImplCopyWith<$Res> {
  __$$RegisterLocationChangedImplCopyWithImpl(
    _$RegisterLocationChangedImpl _value,
    $Res Function(_$RegisterLocationChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$RegisterLocationChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RegisterLocationChangedImpl implements _RegisterLocationChanged {
  const _$RegisterLocationChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'AuthEvent.registerLocationChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterLocationChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterLocationChangedImplCopyWith<_$RegisterLocationChangedImpl> get copyWith =>
      __$$RegisterLocationChangedImplCopyWithImpl<_$RegisterLocationChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return registerLocationChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return registerLocationChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (registerLocationChanged != null) {
      return registerLocationChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return registerLocationChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return registerLocationChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (registerLocationChanged != null) {
      return registerLocationChanged(this);
    }
    return orElse();
  }
}

abstract class _RegisterLocationChanged implements AuthEvent {
  const factory _RegisterLocationChanged(final String value) = _$RegisterLocationChangedImpl;

  String get value;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterLocationChangedImplCopyWith<_$RegisterLocationChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterSubmittedImplCopyWith<$Res> {
  factory _$$RegisterSubmittedImplCopyWith(_$RegisterSubmittedImpl value, $Res Function(_$RegisterSubmittedImpl) then) =
      __$$RegisterSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterSubmittedImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$RegisterSubmittedImpl>
    implements _$$RegisterSubmittedImplCopyWith<$Res> {
  __$$RegisterSubmittedImplCopyWithImpl(_$RegisterSubmittedImpl _value, $Res Function(_$RegisterSubmittedImpl) _then)
    : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterSubmittedImpl implements _RegisterSubmitted {
  const _$RegisterSubmittedImpl();

  @override
  String toString() {
    return 'AuthEvent.registerSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$RegisterSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return registerSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return registerSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (registerSubmitted != null) {
      return registerSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return registerSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return registerSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (registerSubmitted != null) {
      return registerSubmitted(this);
    }
    return orElse();
  }
}

abstract class _RegisterSubmitted implements AuthEvent {
  const factory _RegisterSubmitted() = _$RegisterSubmittedImpl;
}

/// @nodoc
abstract class _$$LogoutRequestedImplCopyWith<$Res> {
  factory _$$LogoutRequestedImplCopyWith(_$LogoutRequestedImpl value, $Res Function(_$LogoutRequestedImpl) then) =
      __$$LogoutRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutRequestedImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$LogoutRequestedImpl>
    implements _$$LogoutRequestedImplCopyWith<$Res> {
  __$$LogoutRequestedImplCopyWithImpl(_$LogoutRequestedImpl _value, $Res Function(_$LogoutRequestedImpl) _then)
    : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutRequestedImpl implements _LogoutRequested {
  const _$LogoutRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.logoutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$LogoutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return logoutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return logoutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return logoutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return logoutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested(this);
    }
    return orElse();
  }
}

abstract class _LogoutRequested implements AuthEvent {
  const factory _LogoutRequested() = _$LogoutRequestedImpl;
}

/// @nodoc
abstract class _$$RefreshRequestedImplCopyWith<$Res> {
  factory _$$RefreshRequestedImplCopyWith(_$RefreshRequestedImpl value, $Res Function(_$RefreshRequestedImpl) then) =
      __$$RefreshRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshRequestedImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$RefreshRequestedImpl>
    implements _$$RefreshRequestedImplCopyWith<$Res> {
  __$$RefreshRequestedImplCopyWithImpl(_$RefreshRequestedImpl _value, $Res Function(_$RefreshRequestedImpl) _then)
    : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshRequestedImpl implements _RefreshRequested {
  const _$RefreshRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.refreshRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$RefreshRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class _RefreshRequested implements AuthEvent {
  const factory _RefreshRequested() = _$RefreshRequestedImpl;
}

/// @nodoc
abstract class _$$ClearErrorsImplCopyWith<$Res> {
  factory _$$ClearErrorsImplCopyWith(_$ClearErrorsImpl value, $Res Function(_$ClearErrorsImpl) then) =
      __$$ClearErrorsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearErrorsImplCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res, _$ClearErrorsImpl>
    implements _$$ClearErrorsImplCopyWith<$Res> {
  __$$ClearErrorsImplCopyWithImpl(_$ClearErrorsImpl _value, $Res Function(_$ClearErrorsImpl) _then)
    : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorsImpl implements _ClearErrors {
  const _$ClearErrorsImpl();

  @override
  String toString() {
    return 'AuthEvent.clearErrors()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$ClearErrorsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String value) loginEmailChanged,
    required TResult Function(String value) loginPasswordChanged,
    required TResult Function() loginSubmitted,
    required TResult Function(String value) registerEmailChanged,
    required TResult Function(String value) registerPasswordChanged,
    required TResult Function(String value) registerNameChanged,
    required TResult Function(String value) registerLocationChanged,
    required TResult Function() registerSubmitted,
    required TResult Function() logoutRequested,
    required TResult Function() refreshRequested,
    required TResult Function() clearErrors,
  }) {
    return clearErrors();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String value)? loginEmailChanged,
    TResult? Function(String value)? loginPasswordChanged,
    TResult? Function()? loginSubmitted,
    TResult? Function(String value)? registerEmailChanged,
    TResult? Function(String value)? registerPasswordChanged,
    TResult? Function(String value)? registerNameChanged,
    TResult? Function(String value)? registerLocationChanged,
    TResult? Function()? registerSubmitted,
    TResult? Function()? logoutRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? clearErrors,
  }) {
    return clearErrors?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String value)? loginEmailChanged,
    TResult Function(String value)? loginPasswordChanged,
    TResult Function()? loginSubmitted,
    TResult Function(String value)? registerEmailChanged,
    TResult Function(String value)? registerPasswordChanged,
    TResult Function(String value)? registerNameChanged,
    TResult Function(String value)? registerLocationChanged,
    TResult Function()? registerSubmitted,
    TResult Function()? logoutRequested,
    TResult Function()? refreshRequested,
    TResult Function()? clearErrors,
    required TResult orElse(),
  }) {
    if (clearErrors != null) {
      return clearErrors();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterEmailChanged value) registerEmailChanged,
    required TResult Function(_RegisterPasswordChanged value) registerPasswordChanged,
    required TResult Function(_RegisterNameChanged value) registerNameChanged,
    required TResult Function(_RegisterLocationChanged value) registerLocationChanged,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_ClearErrors value) clearErrors,
  }) {
    return clearErrors(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult? Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult? Function(_RegisterNameChanged value)? registerNameChanged,
    TResult? Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_ClearErrors value)? clearErrors,
  }) {
    return clearErrors?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterEmailChanged value)? registerEmailChanged,
    TResult Function(_RegisterPasswordChanged value)? registerPasswordChanged,
    TResult Function(_RegisterNameChanged value)? registerNameChanged,
    TResult Function(_RegisterLocationChanged value)? registerLocationChanged,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_ClearErrors value)? clearErrors,
    required TResult orElse(),
  }) {
    if (clearErrors != null) {
      return clearErrors(this);
    }
    return orElse();
  }
}

abstract class _ClearErrors implements AuthEvent {
  const factory _ClearErrors() = _$ClearErrorsImpl;
}

/// @nodoc
mixin _$AuthState {
  AuthStatus get status => throw _privateConstructorUsedError;
  AuthSession? get session => throw _privateConstructorUsedError;
  bool get isCheckingStatus => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError; // Login
  String get loginEmail => throw _privateConstructorUsedError;
  String get loginPassword => throw _privateConstructorUsedError;
  bool get isSubmittingLogin => throw _privateConstructorUsedError;
  String? get loginErrorMessage => throw _privateConstructorUsedError; // Register
  String get registerEmail => throw _privateConstructorUsedError;
  String get registerPassword => throw _privateConstructorUsedError;
  String get registerName => throw _privateConstructorUsedError;
  String get registerLocation => throw _privateConstructorUsedError;
  bool get isSubmittingRegister => throw _privateConstructorUsedError;
  String? get registerErrorMessage => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) = _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({
    AuthStatus status,
    AuthSession? session,
    bool isCheckingStatus,
    String? errorMessage,
    String loginEmail,
    String loginPassword,
    bool isSubmittingLogin,
    String? loginErrorMessage,
    String registerEmail,
    String registerPassword,
    String registerName,
    String registerLocation,
    bool isSubmittingRegister,
    String? registerErrorMessage,
  });

  $AuthSessionCopyWith<$Res>? get session;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? session = freezed,
    Object? isCheckingStatus = null,
    Object? errorMessage = freezed,
    Object? loginEmail = null,
    Object? loginPassword = null,
    Object? isSubmittingLogin = null,
    Object? loginErrorMessage = freezed,
    Object? registerEmail = null,
    Object? registerPassword = null,
    Object? registerName = null,
    Object? registerLocation = null,
    Object? isSubmittingRegister = null,
    Object? registerErrorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AuthStatus,
            session: freezed == session
                ? _value.session
                : session // ignore: cast_nullable_to_non_nullable
                      as AuthSession?,
            isCheckingStatus: null == isCheckingStatus
                ? _value.isCheckingStatus
                : isCheckingStatus // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            loginEmail: null == loginEmail
                ? _value.loginEmail
                : loginEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            loginPassword: null == loginPassword
                ? _value.loginPassword
                : loginPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            isSubmittingLogin: null == isSubmittingLogin
                ? _value.isSubmittingLogin
                : isSubmittingLogin // ignore: cast_nullable_to_non_nullable
                      as bool,
            loginErrorMessage: freezed == loginErrorMessage
                ? _value.loginErrorMessage
                : loginErrorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            registerEmail: null == registerEmail
                ? _value.registerEmail
                : registerEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            registerPassword: null == registerPassword
                ? _value.registerPassword
                : registerPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            registerName: null == registerName
                ? _value.registerName
                : registerName // ignore: cast_nullable_to_non_nullable
                      as String,
            registerLocation: null == registerLocation
                ? _value.registerLocation
                : registerLocation // ignore: cast_nullable_to_non_nullable
                      as String,
            isSubmittingRegister: null == isSubmittingRegister
                ? _value.isSubmittingRegister
                : isSubmittingRegister // ignore: cast_nullable_to_non_nullable
                      as bool,
            registerErrorMessage: freezed == registerErrorMessage
                ? _value.registerErrorMessage
                : registerErrorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthSessionCopyWith<$Res>? get session {
    if (_value.session == null) {
      return null;
    }

    return $AuthSessionCopyWith<$Res>(_value.session!, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(_$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AuthStatus status,
    AuthSession? session,
    bool isCheckingStatus,
    String? errorMessage,
    String loginEmail,
    String loginPassword,
    bool isSubmittingLogin,
    String? loginErrorMessage,
    String registerEmail,
    String registerPassword,
    String registerName,
    String registerLocation,
    bool isSubmittingRegister,
    String? registerErrorMessage,
  });

  @override
  $AuthSessionCopyWith<$Res>? get session;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(_$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? session = freezed,
    Object? isCheckingStatus = null,
    Object? errorMessage = freezed,
    Object? loginEmail = null,
    Object? loginPassword = null,
    Object? isSubmittingLogin = null,
    Object? loginErrorMessage = freezed,
    Object? registerEmail = null,
    Object? registerPassword = null,
    Object? registerName = null,
    Object? registerLocation = null,
    Object? isSubmittingRegister = null,
    Object? registerErrorMessage = freezed,
  }) {
    return _then(
      _$AuthStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
        session: freezed == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                  as AuthSession?,
        isCheckingStatus: null == isCheckingStatus
            ? _value.isCheckingStatus
            : isCheckingStatus // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        loginEmail: null == loginEmail
            ? _value.loginEmail
            : loginEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        loginPassword: null == loginPassword
            ? _value.loginPassword
            : loginPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        isSubmittingLogin: null == isSubmittingLogin
            ? _value.isSubmittingLogin
            : isSubmittingLogin // ignore: cast_nullable_to_non_nullable
                  as bool,
        loginErrorMessage: freezed == loginErrorMessage
            ? _value.loginErrorMessage
            : loginErrorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        registerEmail: null == registerEmail
            ? _value.registerEmail
            : registerEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        registerPassword: null == registerPassword
            ? _value.registerPassword
            : registerPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        registerName: null == registerName
            ? _value.registerName
            : registerName // ignore: cast_nullable_to_non_nullable
                  as String,
        registerLocation: null == registerLocation
            ? _value.registerLocation
            : registerLocation // ignore: cast_nullable_to_non_nullable
                  as String,
        isSubmittingRegister: null == isSubmittingRegister
            ? _value.isSubmittingRegister
            : isSubmittingRegister // ignore: cast_nullable_to_non_nullable
                  as bool,
        registerErrorMessage: freezed == registerErrorMessage
            ? _value.registerErrorMessage
            : registerErrorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateImpl extends _AuthState {
  const _$AuthStateImpl({
    this.status = AuthStatus.unknown,
    this.session,
    this.isCheckingStatus = false,
    this.errorMessage,
    this.loginEmail = '',
    this.loginPassword = '',
    this.isSubmittingLogin = false,
    this.loginErrorMessage,
    this.registerEmail = '',
    this.registerPassword = '',
    this.registerName = '',
    this.registerLocation = '',
    this.isSubmittingRegister = false,
    this.registerErrorMessage,
  }) : super._();

  @override
  @JsonKey()
  final AuthStatus status;
  @override
  final AuthSession? session;
  @override
  @JsonKey()
  final bool isCheckingStatus;
  @override
  final String? errorMessage;
  // Login
  @override
  @JsonKey()
  final String loginEmail;
  @override
  @JsonKey()
  final String loginPassword;
  @override
  @JsonKey()
  final bool isSubmittingLogin;
  @override
  final String? loginErrorMessage;
  // Register
  @override
  @JsonKey()
  final String registerEmail;
  @override
  @JsonKey()
  final String registerPassword;
  @override
  @JsonKey()
  final String registerName;
  @override
  @JsonKey()
  final String registerLocation;
  @override
  @JsonKey()
  final bool isSubmittingRegister;
  @override
  final String? registerErrorMessage;

  @override
  String toString() {
    return 'AuthState(status: $status, session: $session, isCheckingStatus: $isCheckingStatus, errorMessage: $errorMessage, loginEmail: $loginEmail, loginPassword: $loginPassword, isSubmittingLogin: $isSubmittingLogin, loginErrorMessage: $loginErrorMessage, registerEmail: $registerEmail, registerPassword: $registerPassword, registerName: $registerName, registerLocation: $registerLocation, isSubmittingRegister: $isSubmittingRegister, registerErrorMessage: $registerErrorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.isCheckingStatus, isCheckingStatus) || other.isCheckingStatus == isCheckingStatus) &&
            (identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage) &&
            (identical(other.loginEmail, loginEmail) || other.loginEmail == loginEmail) &&
            (identical(other.loginPassword, loginPassword) || other.loginPassword == loginPassword) &&
            (identical(other.isSubmittingLogin, isSubmittingLogin) || other.isSubmittingLogin == isSubmittingLogin) &&
            (identical(other.loginErrorMessage, loginErrorMessage) || other.loginErrorMessage == loginErrorMessage) &&
            (identical(other.registerEmail, registerEmail) || other.registerEmail == registerEmail) &&
            (identical(other.registerPassword, registerPassword) || other.registerPassword == registerPassword) &&
            (identical(other.registerName, registerName) || other.registerName == registerName) &&
            (identical(other.registerLocation, registerLocation) || other.registerLocation == registerLocation) &&
            (identical(other.isSubmittingRegister, isSubmittingRegister) ||
                other.isSubmittingRegister == isSubmittingRegister) &&
            (identical(other.registerErrorMessage, registerErrorMessage) ||
                other.registerErrorMessage == registerErrorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    session,
    isCheckingStatus,
    errorMessage,
    loginEmail,
    loginPassword,
    isSubmittingLogin,
    loginErrorMessage,
    registerEmail,
    registerPassword,
    registerName,
    registerLocation,
    isSubmittingRegister,
    registerErrorMessage,
  );

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState extends AuthState {
  const factory _AuthState({
    final AuthStatus status,
    final AuthSession? session,
    final bool isCheckingStatus,
    final String? errorMessage,
    final String loginEmail,
    final String loginPassword,
    final bool isSubmittingLogin,
    final String? loginErrorMessage,
    final String registerEmail,
    final String registerPassword,
    final String registerName,
    final String registerLocation,
    final bool isSubmittingRegister,
    final String? registerErrorMessage,
  }) = _$AuthStateImpl;
  const _AuthState._() : super._();

  @override
  AuthStatus get status;
  @override
  AuthSession? get session;
  @override
  bool get isCheckingStatus;
  @override
  String? get errorMessage; // Login
  @override
  String get loginEmail;
  @override
  String get loginPassword;
  @override
  bool get isSubmittingLogin;
  @override
  String? get loginErrorMessage; // Register
  @override
  String get registerEmail;
  @override
  String get registerPassword;
  @override
  String get registerName;
  @override
  String get registerLocation;
  @override
  bool get isSubmittingRegister;
  @override
  String? get registerErrorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith => throw _privateConstructorUsedError;
}
