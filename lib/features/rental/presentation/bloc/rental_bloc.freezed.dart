// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rental_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RentalEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RentalEventCopyWith<$Res> {
  factory $RentalEventCopyWith(RentalEvent value, $Res Function(RentalEvent) then) =
      _$RentalEventCopyWithImpl<$Res, RentalEvent>;
}

/// @nodoc
class _$RentalEventCopyWithImpl<$Res, $Val extends RentalEvent> implements $RentalEventCopyWith<$Res> {
  _$RentalEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(_$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String gameId, String? startDate, String? endDate});
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res> extends _$RentalEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(_$StartedImpl _value, $Res Function(_$StartedImpl) _then) : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? gameId = null, Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _$StartedImpl(
        gameId: null == gameId
            ? _value.gameId
            : gameId // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl({required this.gameId, this.startDate, this.endDate});

  @override
  final String gameId;
  @override
  final String? startDate;
  @override
  final String? endDate;

  @override
  String toString() {
    return 'RentalEvent.started(gameId: $gameId, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartedImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.startDate, startDate) || other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameId, startDate, endDate);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith => __$$StartedImplCopyWithImpl<_$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return started(gameId, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return started?.call(gameId, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(gameId, startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements RentalEvent {
  const factory _Started({required final String gameId, final String? startDate, final String? endDate}) =
      _$StartedImpl;

  String get gameId;
  String? get startDate;
  String? get endDate;

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StartDateChangedImplCopyWith<$Res> {
  factory _$$StartDateChangedImplCopyWith(_$StartDateChangedImpl value, $Res Function(_$StartDateChangedImpl) then) =
      __$$StartDateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? value});
}

/// @nodoc
class __$$StartDateChangedImplCopyWithImpl<$Res> extends _$RentalEventCopyWithImpl<$Res, _$StartDateChangedImpl>
    implements _$$StartDateChangedImplCopyWith<$Res> {
  __$$StartDateChangedImplCopyWithImpl(_$StartDateChangedImpl _value, $Res Function(_$StartDateChangedImpl) _then)
    : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = freezed}) {
    return _then(
      _$StartDateChangedImpl(
        freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$StartDateChangedImpl implements _StartDateChanged {
  const _$StartDateChangedImpl(this.value);

  @override
  final String? value;

  @override
  String toString() {
    return 'RentalEvent.startDateChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartDateChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartDateChangedImplCopyWith<_$StartDateChangedImpl> get copyWith =>
      __$$StartDateChangedImplCopyWithImpl<_$StartDateChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return startDateChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return startDateChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (startDateChanged != null) {
      return startDateChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return startDateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return startDateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (startDateChanged != null) {
      return startDateChanged(this);
    }
    return orElse();
  }
}

abstract class _StartDateChanged implements RentalEvent {
  const factory _StartDateChanged(final String? value) = _$StartDateChangedImpl;

  String? get value;

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartDateChangedImplCopyWith<_$StartDateChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EndDateChangedImplCopyWith<$Res> {
  factory _$$EndDateChangedImplCopyWith(_$EndDateChangedImpl value, $Res Function(_$EndDateChangedImpl) then) =
      __$$EndDateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? value});
}

/// @nodoc
class __$$EndDateChangedImplCopyWithImpl<$Res> extends _$RentalEventCopyWithImpl<$Res, _$EndDateChangedImpl>
    implements _$$EndDateChangedImplCopyWith<$Res> {
  __$$EndDateChangedImplCopyWithImpl(_$EndDateChangedImpl _value, $Res Function(_$EndDateChangedImpl) _then)
    : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = freezed}) {
    return _then(
      _$EndDateChangedImpl(
        freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$EndDateChangedImpl implements _EndDateChanged {
  const _$EndDateChangedImpl(this.value);

  @override
  final String? value;

  @override
  String toString() {
    return 'RentalEvent.endDateChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EndDateChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EndDateChangedImplCopyWith<_$EndDateChangedImpl> get copyWith =>
      __$$EndDateChangedImplCopyWithImpl<_$EndDateChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return endDateChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return endDateChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (endDateChanged != null) {
      return endDateChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return endDateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return endDateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (endDateChanged != null) {
      return endDateChanged(this);
    }
    return orElse();
  }
}

abstract class _EndDateChanged implements RentalEvent {
  const factory _EndDateChanged(final String? value) = _$EndDateChangedImpl;

  String? get value;

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EndDateChangedImplCopyWith<_$EndDateChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeliveryChangedImplCopyWith<$Res> {
  factory _$$DeliveryChangedImplCopyWith(_$DeliveryChangedImpl value, $Res Function(_$DeliveryChangedImpl) then) =
      __$$DeliveryChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isDelivery});
}

/// @nodoc
class __$$DeliveryChangedImplCopyWithImpl<$Res> extends _$RentalEventCopyWithImpl<$Res, _$DeliveryChangedImpl>
    implements _$$DeliveryChangedImplCopyWith<$Res> {
  __$$DeliveryChangedImplCopyWithImpl(_$DeliveryChangedImpl _value, $Res Function(_$DeliveryChangedImpl) _then)
    : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isDelivery = null}) {
    return _then(
      _$DeliveryChangedImpl(
        isDelivery: null == isDelivery
            ? _value.isDelivery
            : isDelivery // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$DeliveryChangedImpl implements _DeliveryChanged {
  const _$DeliveryChangedImpl({required this.isDelivery});

  @override
  final bool isDelivery;

  @override
  String toString() {
    return 'RentalEvent.deliveryChanged(isDelivery: $isDelivery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryChangedImpl &&
            (identical(other.isDelivery, isDelivery) || other.isDelivery == isDelivery));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isDelivery);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryChangedImplCopyWith<_$DeliveryChangedImpl> get copyWith =>
      __$$DeliveryChangedImplCopyWithImpl<_$DeliveryChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return deliveryChanged(isDelivery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return deliveryChanged?.call(isDelivery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (deliveryChanged != null) {
      return deliveryChanged(isDelivery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return deliveryChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return deliveryChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (deliveryChanged != null) {
      return deliveryChanged(this);
    }
    return orElse();
  }
}

abstract class _DeliveryChanged implements RentalEvent {
  const factory _DeliveryChanged({required bool isDelivery}) = _$DeliveryChangedImpl;

  bool get isDelivery;

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryChangedImplCopyWith<_$DeliveryChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeliveryAddressChangedImplCopyWith<$Res> {
  factory _$$DeliveryAddressChangedImplCopyWith(
    _$DeliveryAddressChangedImpl value,
    $Res Function(_$DeliveryAddressChangedImpl) then,
  ) = __$$DeliveryAddressChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$DeliveryAddressChangedImplCopyWithImpl<$Res>
    extends _$RentalEventCopyWithImpl<$Res, _$DeliveryAddressChangedImpl>
    implements _$$DeliveryAddressChangedImplCopyWith<$Res> {
  __$$DeliveryAddressChangedImplCopyWithImpl(
    _$DeliveryAddressChangedImpl _value,
    $Res Function(_$DeliveryAddressChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$DeliveryAddressChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeliveryAddressChangedImpl implements _DeliveryAddressChanged {
  const _$DeliveryAddressChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'RentalEvent.deliveryAddressChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryAddressChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryAddressChangedImplCopyWith<_$DeliveryAddressChangedImpl> get copyWith =>
      __$$DeliveryAddressChangedImplCopyWithImpl<_$DeliveryAddressChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return deliveryAddressChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return deliveryAddressChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (deliveryAddressChanged != null) {
      return deliveryAddressChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return deliveryAddressChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return deliveryAddressChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (deliveryAddressChanged != null) {
      return deliveryAddressChanged(this);
    }
    return orElse();
  }
}

abstract class _DeliveryAddressChanged implements RentalEvent {
  const factory _DeliveryAddressChanged(final String value) = _$DeliveryAddressChangedImpl;

  String get value;

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryAddressChangedImplCopyWith<_$DeliveryAddressChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeliveryCommentsChangedImplCopyWith<$Res> {
  factory _$$DeliveryCommentsChangedImplCopyWith(
    _$DeliveryCommentsChangedImpl value,
    $Res Function(_$DeliveryCommentsChangedImpl) then,
  ) = __$$DeliveryCommentsChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$DeliveryCommentsChangedImplCopyWithImpl<$Res>
    extends _$RentalEventCopyWithImpl<$Res, _$DeliveryCommentsChangedImpl>
    implements _$$DeliveryCommentsChangedImplCopyWith<$Res> {
  __$$DeliveryCommentsChangedImplCopyWithImpl(
    _$DeliveryCommentsChangedImpl _value,
    $Res Function(_$DeliveryCommentsChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$DeliveryCommentsChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeliveryCommentsChangedImpl implements _DeliveryCommentsChanged {
  const _$DeliveryCommentsChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'RentalEvent.deliveryCommentsChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryCommentsChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryCommentsChangedImplCopyWith<_$DeliveryCommentsChangedImpl> get copyWith =>
      __$$DeliveryCommentsChangedImplCopyWithImpl<_$DeliveryCommentsChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return deliveryCommentsChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return deliveryCommentsChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (deliveryCommentsChanged != null) {
      return deliveryCommentsChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return deliveryCommentsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return deliveryCommentsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (deliveryCommentsChanged != null) {
      return deliveryCommentsChanged(this);
    }
    return orElse();
  }
}

abstract class _DeliveryCommentsChanged implements RentalEvent {
  const factory _DeliveryCommentsChanged(final String value) = _$DeliveryCommentsChangedImpl;

  String get value;

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryCommentsChangedImplCopyWith<_$DeliveryCommentsChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentMethodChangedImplCopyWith<$Res> {
  factory _$$PaymentMethodChangedImplCopyWith(
    _$PaymentMethodChangedImpl value,
    $Res Function(_$PaymentMethodChangedImpl) then,
  ) = __$$PaymentMethodChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$PaymentMethodChangedImplCopyWithImpl<$Res> extends _$RentalEventCopyWithImpl<$Res, _$PaymentMethodChangedImpl>
    implements _$$PaymentMethodChangedImplCopyWith<$Res> {
  __$$PaymentMethodChangedImplCopyWithImpl(
    _$PaymentMethodChangedImpl _value,
    $Res Function(_$PaymentMethodChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$PaymentMethodChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PaymentMethodChangedImpl implements _PaymentMethodChanged {
  const _$PaymentMethodChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'RentalEvent.paymentMethodChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodChangedImplCopyWith<_$PaymentMethodChangedImpl> get copyWith =>
      __$$PaymentMethodChangedImplCopyWithImpl<_$PaymentMethodChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return paymentMethodChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return paymentMethodChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (paymentMethodChanged != null) {
      return paymentMethodChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return paymentMethodChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return paymentMethodChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (paymentMethodChanged != null) {
      return paymentMethodChanged(this);
    }
    return orElse();
  }
}

abstract class _PaymentMethodChanged implements RentalEvent {
  const factory _PaymentMethodChanged(final String value) = _$PaymentMethodChangedImpl;

  String get value;

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentMethodChangedImplCopyWith<_$PaymentMethodChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FoodBundlesChangedImplCopyWith<$Res> {
  factory _$$FoodBundlesChangedImplCopyWith(
    _$FoodBundlesChangedImpl value,
    $Res Function(_$FoodBundlesChangedImpl) then,
  ) = __$$FoodBundlesChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> value});
}

/// @nodoc
class __$$FoodBundlesChangedImplCopyWithImpl<$Res> extends _$RentalEventCopyWithImpl<$Res, _$FoodBundlesChangedImpl>
    implements _$$FoodBundlesChangedImplCopyWith<$Res> {
  __$$FoodBundlesChangedImplCopyWithImpl(_$FoodBundlesChangedImpl _value, $Res Function(_$FoodBundlesChangedImpl) _then)
    : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$FoodBundlesChangedImpl(
        null == value
            ? _value._value
            : value // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$FoodBundlesChangedImpl implements _FoodBundlesChanged {
  const _$FoodBundlesChangedImpl(final List<String> value) : _value = value;

  final List<String> _value;
  @override
  List<String> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  @override
  String toString() {
    return 'RentalEvent.foodBundlesChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodBundlesChangedImpl &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodBundlesChangedImplCopyWith<_$FoodBundlesChangedImpl> get copyWith =>
      __$$FoodBundlesChangedImplCopyWithImpl<_$FoodBundlesChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return foodBundlesChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return foodBundlesChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (foodBundlesChanged != null) {
      return foodBundlesChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return foodBundlesChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return foodBundlesChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (foodBundlesChanged != null) {
      return foodBundlesChanged(this);
    }
    return orElse();
  }
}

abstract class _FoodBundlesChanged implements RentalEvent {
  const factory _FoodBundlesChanged(final List<String> value) = _$FoodBundlesChangedImpl;

  List<String> get value;

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodBundlesChangedImplCopyWith<_$FoodBundlesChangedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmittedImplCopyWith<$Res> {
  factory _$$SubmittedImplCopyWith(_$SubmittedImpl value, $Res Function(_$SubmittedImpl) then) =
      __$$SubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmittedImplCopyWithImpl<$Res> extends _$RentalEventCopyWithImpl<$Res, _$SubmittedImpl>
    implements _$$SubmittedImplCopyWith<$Res> {
  __$$SubmittedImplCopyWithImpl(_$SubmittedImpl _value, $Res Function(_$SubmittedImpl) _then) : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmittedImpl implements _Submitted {
  const _$SubmittedImpl();

  @override
  String toString() {
    return 'RentalEvent.submitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$SubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class _Submitted implements RentalEvent {
  const factory _Submitted() = _$SubmittedImpl;
}

/// @nodoc
abstract class _$$MessageShownImplCopyWith<$Res> {
  factory _$$MessageShownImplCopyWith(_$MessageShownImpl value, $Res Function(_$MessageShownImpl) then) =
      __$$MessageShownImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MessageShownImplCopyWithImpl<$Res> extends _$RentalEventCopyWithImpl<$Res, _$MessageShownImpl>
    implements _$$MessageShownImplCopyWith<$Res> {
  __$$MessageShownImplCopyWithImpl(_$MessageShownImpl _value, $Res Function(_$MessageShownImpl) _then)
    : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MessageShownImpl implements _MessageShown {
  const _$MessageShownImpl();

  @override
  String toString() {
    return 'RentalEvent.messageShown()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$MessageShownImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return messageShown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return messageShown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (messageShown != null) {
      return messageShown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return messageShown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return messageShown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (messageShown != null) {
      return messageShown(this);
    }
    return orElse();
  }
}

abstract class _MessageShown implements RentalEvent {
  const factory _MessageShown() = _$MessageShownImpl;
}

/// @nodoc
abstract class _$$PublishAnotherImplCopyWith<$Res> {
  factory _$$PublishAnotherImplCopyWith(_$PublishAnotherImpl value, $Res Function(_$PublishAnotherImpl) then) =
      __$$PublishAnotherImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PublishAnotherImplCopyWithImpl<$Res> extends _$RentalEventCopyWithImpl<$Res, _$PublishAnotherImpl>
    implements _$$PublishAnotherImplCopyWith<$Res> {
  __$$PublishAnotherImplCopyWithImpl(_$PublishAnotherImpl _value, $Res Function(_$PublishAnotherImpl) _then)
    : super(_value, _then);

  /// Create a copy of RentalEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PublishAnotherImpl implements _PublishAnother {
  const _$PublishAnotherImpl();

  @override
  String toString() {
    return 'RentalEvent.publishAnother()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$PublishAnotherImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String gameId, String? startDate, String? endDate) started,
    required TResult Function(String? value) startDateChanged,
    required TResult Function(String? value) endDateChanged,
    required TResult Function(bool isDelivery) deliveryChanged,
    required TResult Function(String value) deliveryAddressChanged,
    required TResult Function(String value) deliveryCommentsChanged,
    required TResult Function(String value) paymentMethodChanged,
    required TResult Function(List<String> value) foodBundlesChanged,
    required TResult Function() submitted,
    required TResult Function() messageShown,
    required TResult Function() publishAnother,
  }) {
    return publishAnother();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String gameId, String? startDate, String? endDate)? started,
    TResult? Function(String? value)? startDateChanged,
    TResult? Function(String? value)? endDateChanged,
    TResult? Function(bool isDelivery)? deliveryChanged,
    TResult? Function(String value)? deliveryAddressChanged,
    TResult? Function(String value)? deliveryCommentsChanged,
    TResult? Function(String value)? paymentMethodChanged,
    TResult? Function(List<String> value)? foodBundlesChanged,
    TResult? Function()? submitted,
    TResult? Function()? messageShown,
    TResult? Function()? publishAnother,
  }) {
    return publishAnother?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String gameId, String? startDate, String? endDate)? started,
    TResult Function(String? value)? startDateChanged,
    TResult Function(String? value)? endDateChanged,
    TResult Function(bool isDelivery)? deliveryChanged,
    TResult Function(String value)? deliveryAddressChanged,
    TResult Function(String value)? deliveryCommentsChanged,
    TResult Function(String value)? paymentMethodChanged,
    TResult Function(List<String> value)? foodBundlesChanged,
    TResult Function()? submitted,
    TResult Function()? messageShown,
    TResult Function()? publishAnother,
    required TResult orElse(),
  }) {
    if (publishAnother != null) {
      return publishAnother();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartDateChanged value) startDateChanged,
    required TResult Function(_EndDateChanged value) endDateChanged,
    required TResult Function(_DeliveryChanged value) deliveryChanged,
    required TResult Function(_DeliveryAddressChanged value) deliveryAddressChanged,
    required TResult Function(_DeliveryCommentsChanged value) deliveryCommentsChanged,
    required TResult Function(_PaymentMethodChanged value) paymentMethodChanged,
    required TResult Function(_FoodBundlesChanged value) foodBundlesChanged,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_MessageShown value) messageShown,
    required TResult Function(_PublishAnother value) publishAnother,
  }) {
    return publishAnother(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StartDateChanged value)? startDateChanged,
    TResult? Function(_EndDateChanged value)? endDateChanged,
    TResult? Function(_DeliveryChanged value)? deliveryChanged,
    TResult? Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult? Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult? Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult? Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_MessageShown value)? messageShown,
    TResult? Function(_PublishAnother value)? publishAnother,
  }) {
    return publishAnother?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartDateChanged value)? startDateChanged,
    TResult Function(_EndDateChanged value)? endDateChanged,
    TResult Function(_DeliveryChanged value)? deliveryChanged,
    TResult Function(_DeliveryAddressChanged value)? deliveryAddressChanged,
    TResult Function(_DeliveryCommentsChanged value)? deliveryCommentsChanged,
    TResult Function(_PaymentMethodChanged value)? paymentMethodChanged,
    TResult Function(_FoodBundlesChanged value)? foodBundlesChanged,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_MessageShown value)? messageShown,
    TResult Function(_PublishAnother value)? publishAnother,
    required TResult orElse(),
  }) {
    if (publishAnother != null) {
      return publishAnother(this);
    }
    return orElse();
  }
}

abstract class _PublishAnother implements RentalEvent {
  const factory _PublishAnother() = _$PublishAnotherImpl;
}

/// @nodoc
mixin _$RentalState {
  bool get isLoading => throw _privateConstructorUsedError;
  Game? get game => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  String? get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;
  bool get isDelivery => throw _privateConstructorUsedError;
  String get deliveryAddress => throw _privateConstructorUsedError;
  String get deliveryComments => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  List<String> get selectedFoodBundles => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  String? get snackbarMessage => throw _privateConstructorUsedError;

  /// Create a copy of RentalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RentalStateCopyWith<RentalState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RentalStateCopyWith<$Res> {
  factory $RentalStateCopyWith(RentalState value, $Res Function(RentalState) then) =
      _$RentalStateCopyWithImpl<$Res, RentalState>;
  @useResult
  $Res call({
    bool isLoading,
    Game? game,
    String? errorMessage,
    bool success,
    String? startDate,
    String? endDate,
    bool isDelivery,
    String deliveryAddress,
    String deliveryComments,
    String paymentMethod,
    List<String> selectedFoodBundles,
    bool isSubmitting,
    String? snackbarMessage,
  });

  $GameCopyWith<$Res>? get game;
}

/// @nodoc
class _$RentalStateCopyWithImpl<$Res, $Val extends RentalState> implements $RentalStateCopyWith<$Res> {
  _$RentalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RentalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? game = freezed,
    Object? errorMessage = freezed,
    Object? success = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isDelivery = null,
    Object? deliveryAddress = null,
    Object? deliveryComments = null,
    Object? paymentMethod = null,
    Object? selectedFoodBundles = null,
    Object? isSubmitting = null,
    Object? snackbarMessage = freezed,
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
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDelivery: null == isDelivery
                ? _value.isDelivery
                : isDelivery // ignore: cast_nullable_to_non_nullable
                      as bool,
            deliveryAddress: null == deliveryAddress
                ? _value.deliveryAddress
                : deliveryAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            deliveryComments: null == deliveryComments
                ? _value.deliveryComments
                : deliveryComments // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedFoodBundles: null == selectedFoodBundles
                ? _value.selectedFoodBundles
                : selectedFoodBundles // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            snackbarMessage: freezed == snackbarMessage
                ? _value.snackbarMessage
                : snackbarMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of RentalState
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
abstract class _$$RentalStateImplCopyWith<$Res> implements $RentalStateCopyWith<$Res> {
  factory _$$RentalStateImplCopyWith(_$RentalStateImpl value, $Res Function(_$RentalStateImpl) then) =
      __$$RentalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    Game? game,
    String? errorMessage,
    bool success,
    String? startDate,
    String? endDate,
    bool isDelivery,
    String deliveryAddress,
    String deliveryComments,
    String paymentMethod,
    List<String> selectedFoodBundles,
    bool isSubmitting,
    String? snackbarMessage,
  });

  @override
  $GameCopyWith<$Res>? get game;
}

/// @nodoc
class __$$RentalStateImplCopyWithImpl<$Res> extends _$RentalStateCopyWithImpl<$Res, _$RentalStateImpl>
    implements _$$RentalStateImplCopyWith<$Res> {
  __$$RentalStateImplCopyWithImpl(_$RentalStateImpl _value, $Res Function(_$RentalStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of RentalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? game = freezed,
    Object? errorMessage = freezed,
    Object? success = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isDelivery = null,
    Object? deliveryAddress = null,
    Object? deliveryComments = null,
    Object? paymentMethod = null,
    Object? selectedFoodBundles = null,
    Object? isSubmitting = null,
    Object? snackbarMessage = freezed,
  }) {
    return _then(
      _$RentalStateImpl(
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
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDelivery: null == isDelivery
            ? _value.isDelivery
            : isDelivery // ignore: cast_nullable_to_non_nullable
                  as bool,
        deliveryAddress: null == deliveryAddress
            ? _value.deliveryAddress
            : deliveryAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        deliveryComments: null == deliveryComments
            ? _value.deliveryComments
            : deliveryComments // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedFoodBundles: null == selectedFoodBundles
            ? _value._selectedFoodBundles
            : selectedFoodBundles // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        snackbarMessage: freezed == snackbarMessage
            ? _value.snackbarMessage
            : snackbarMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RentalStateImpl extends _RentalState {
  const _$RentalStateImpl({
    this.isLoading = false,
    this.game,
    this.errorMessage,
    this.success = false,
    this.startDate,
    this.endDate,
    this.isDelivery = false,
    this.deliveryAddress = '',
    this.deliveryComments = '',
    this.paymentMethod = 'mercadopago',
    final List<String> selectedFoodBundles = const [],
    this.isSubmitting = false,
    this.snackbarMessage,
  }) : _selectedFoodBundles = selectedFoodBundles,
       super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Game? game;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool success;
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  @JsonKey()
  final bool isDelivery;
  @override
  @JsonKey()
  final String deliveryAddress;
  @override
  @JsonKey()
  final String deliveryComments;
  @override
  @JsonKey()
  final String paymentMethod;
  final List<String> _selectedFoodBundles;
  @override
  @JsonKey()
  List<String> get selectedFoodBundles {
    if (_selectedFoodBundles is EqualUnmodifiableListView) return _selectedFoodBundles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedFoodBundles);
  }

  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final String? snackbarMessage;

  @override
  String toString() {
    return 'RentalState(isLoading: $isLoading, game: $game, errorMessage: $errorMessage, success: $success, startDate: $startDate, endDate: $endDate, isDelivery: $isDelivery, deliveryAddress: $deliveryAddress, deliveryComments: $deliveryComments, paymentMethod: $paymentMethod, selectedFoodBundles: $selectedFoodBundles, isSubmitting: $isSubmitting, snackbarMessage: $snackbarMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RentalStateImpl &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.game, game) || other.game == game) &&
            (identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.startDate, startDate) || other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isDelivery, isDelivery) || other.isDelivery == isDelivery) &&
            (identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress) &&
            (identical(other.deliveryComments, deliveryComments) || other.deliveryComments == deliveryComments) &&
            (identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(other._selectedFoodBundles, _selectedFoodBundles) &&
            (identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting) &&
            (identical(other.snackbarMessage, snackbarMessage) || other.snackbarMessage == snackbarMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    game,
    errorMessage,
    success,
    startDate,
    endDate,
    isDelivery,
    deliveryAddress,
    deliveryComments,
    paymentMethod,
    const DeepCollectionEquality().hash(_selectedFoodBundles),
    isSubmitting,
    snackbarMessage,
  );

  /// Create a copy of RentalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RentalStateImplCopyWith<_$RentalStateImpl> get copyWith =>
      __$$RentalStateImplCopyWithImpl<_$RentalStateImpl>(this, _$identity);
}

abstract class _RentalState extends RentalState {
  const factory _RentalState({
    final bool isLoading,
    final Game? game,
    final String? errorMessage,
    final bool success,
    final String? startDate,
    final String? endDate,
    final bool isDelivery,
    final String deliveryAddress,
    final String deliveryComments,
    final String paymentMethod,
    final List<String> selectedFoodBundles,
    final bool isSubmitting,
    final String? snackbarMessage,
  }) = _$RentalStateImpl;
  const _RentalState._() : super._();

  @override
  bool get isLoading;
  @override
  Game? get game;
  @override
  String? get errorMessage;
  @override
  bool get success;
  @override
  String? get startDate;
  @override
  String? get endDate;
  @override
  bool get isDelivery;
  @override
  String get deliveryAddress;
  @override
  String get deliveryComments;
  @override
  String get paymentMethod;
  @override
  List<String> get selectedFoodBundles;
  @override
  bool get isSubmitting;
  @override
  String? get snackbarMessage;

  /// Create a copy of RentalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RentalStateImplCopyWith<_$RentalStateImpl> get copyWith => throw _privateConstructorUsedError;
}
