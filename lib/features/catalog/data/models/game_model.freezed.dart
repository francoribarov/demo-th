// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AvailabilityRangeModel _$AvailabilityRangeModelFromJson(Map<String, dynamic> json) {
  return _AvailabilityRangeModel.fromJson(json);
}

/// @nodoc
mixin _$AvailabilityRangeModel {
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;

  /// Serializes this AvailabilityRangeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AvailabilityRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailabilityRangeModelCopyWith<AvailabilityRangeModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailabilityRangeModelCopyWith<$Res> {
  factory $AvailabilityRangeModelCopyWith(AvailabilityRangeModel value, $Res Function(AvailabilityRangeModel) then) =
      _$AvailabilityRangeModelCopyWithImpl<$Res, AvailabilityRangeModel>;
  @useResult
  $Res call({String from, String to});
}

/// @nodoc
class _$AvailabilityRangeModelCopyWithImpl<$Res, $Val extends AvailabilityRangeModel>
    implements $AvailabilityRangeModelCopyWith<$Res> {
  _$AvailabilityRangeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailabilityRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? from = null, Object? to = null}) {
    return _then(
      _value.copyWith(
            from: null == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as String,
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AvailabilityRangeModelImplCopyWith<$Res> implements $AvailabilityRangeModelCopyWith<$Res> {
  factory _$$AvailabilityRangeModelImplCopyWith(
    _$AvailabilityRangeModelImpl value,
    $Res Function(_$AvailabilityRangeModelImpl) then,
  ) = __$$AvailabilityRangeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String from, String to});
}

/// @nodoc
class __$$AvailabilityRangeModelImplCopyWithImpl<$Res>
    extends _$AvailabilityRangeModelCopyWithImpl<$Res, _$AvailabilityRangeModelImpl>
    implements _$$AvailabilityRangeModelImplCopyWith<$Res> {
  __$$AvailabilityRangeModelImplCopyWithImpl(
    _$AvailabilityRangeModelImpl _value,
    $Res Function(_$AvailabilityRangeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AvailabilityRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? from = null, Object? to = null}) {
    return _then(
      _$AvailabilityRangeModelImpl(
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as String,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailabilityRangeModelImpl extends _AvailabilityRangeModel {
  const _$AvailabilityRangeModelImpl({required this.from, required this.to}) : super._();

  factory _$AvailabilityRangeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailabilityRangeModelImplFromJson(json);

  @override
  final String from;
  @override
  final String to;

  @override
  String toString() {
    return 'AvailabilityRangeModel(from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailabilityRangeModelImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, from, to);

  /// Create a copy of AvailabilityRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailabilityRangeModelImplCopyWith<_$AvailabilityRangeModelImpl> get copyWith =>
      __$$AvailabilityRangeModelImplCopyWithImpl<_$AvailabilityRangeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailabilityRangeModelImplToJson(this);
  }
}

abstract class _AvailabilityRangeModel extends AvailabilityRangeModel {
  const factory _AvailabilityRangeModel({required final String from, required final String to}) =
      _$AvailabilityRangeModelImpl;
  const _AvailabilityRangeModel._() : super._();

  factory _AvailabilityRangeModel.fromJson(Map<String, dynamic> json) = _$AvailabilityRangeModelImpl.fromJson;

  @override
  String get from;
  @override
  String get to;

  /// Create a copy of AvailabilityRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailabilityRangeModelImplCopyWith<_$AvailabilityRangeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameRulesModel _$GameRulesModelFromJson(Map<String, dynamic> json) {
  return _GameRulesModel.fromJson(json);
}

/// @nodoc
mixin _$GameRulesModel {
  String get video => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  /// Serializes this GameRulesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameRulesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameRulesModelCopyWith<GameRulesModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRulesModelCopyWith<$Res> {
  factory $GameRulesModelCopyWith(GameRulesModel value, $Res Function(GameRulesModel) then) =
      _$GameRulesModelCopyWithImpl<$Res, GameRulesModel>;
  @useResult
  $Res call({String video, String text});
}

/// @nodoc
class _$GameRulesModelCopyWithImpl<$Res, $Val extends GameRulesModel> implements $GameRulesModelCopyWith<$Res> {
  _$GameRulesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameRulesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? video = null, Object? text = null}) {
    return _then(
      _value.copyWith(
            video: null == video
                ? _value.video
                : video // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameRulesModelImplCopyWith<$Res> implements $GameRulesModelCopyWith<$Res> {
  factory _$$GameRulesModelImplCopyWith(_$GameRulesModelImpl value, $Res Function(_$GameRulesModelImpl) then) =
      __$$GameRulesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String video, String text});
}

/// @nodoc
class __$$GameRulesModelImplCopyWithImpl<$Res> extends _$GameRulesModelCopyWithImpl<$Res, _$GameRulesModelImpl>
    implements _$$GameRulesModelImplCopyWith<$Res> {
  __$$GameRulesModelImplCopyWithImpl(_$GameRulesModelImpl _value, $Res Function(_$GameRulesModelImpl) _then)
    : super(_value, _then);

  /// Create a copy of GameRulesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? video = null, Object? text = null}) {
    return _then(
      _$GameRulesModelImpl(
        video: null == video
            ? _value.video
            : video // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameRulesModelImpl extends _GameRulesModel {
  const _$GameRulesModelImpl({required this.video, required this.text}) : super._();

  factory _$GameRulesModelImpl.fromJson(Map<String, dynamic> json) => _$$GameRulesModelImplFromJson(json);

  @override
  final String video;
  @override
  final String text;

  @override
  String toString() {
    return 'GameRulesModel(video: $video, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameRulesModelImpl &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, video, text);

  /// Create a copy of GameRulesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameRulesModelImplCopyWith<_$GameRulesModelImpl> get copyWith =>
      __$$GameRulesModelImplCopyWithImpl<_$GameRulesModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameRulesModelImplToJson(this);
  }
}

abstract class _GameRulesModel extends GameRulesModel {
  const factory _GameRulesModel({required final String video, required final String text}) = _$GameRulesModelImpl;
  const _GameRulesModel._() : super._();

  factory _GameRulesModel.fromJson(Map<String, dynamic> json) = _$GameRulesModelImpl.fromJson;

  @override
  String get video;
  @override
  String get text;

  /// Create a copy of GameRulesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameRulesModelImplCopyWith<_$GameRulesModelImpl> get copyWith => throw _privateConstructorUsedError;
}

GameReviewModel _$GameReviewModelFromJson(Map<String, dynamic> json) {
  return _GameReviewModel.fromJson(json);
}

/// @nodoc
mixin _$GameReviewModel {
  String get name => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;

  /// Serializes this GameReviewModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameReviewModelCopyWith<GameReviewModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameReviewModelCopyWith<$Res> {
  factory $GameReviewModelCopyWith(GameReviewModel value, $Res Function(GameReviewModel) then) =
      _$GameReviewModelCopyWithImpl<$Res, GameReviewModel>;
  @useResult
  $Res call({String name, String role, double rating, String comment});
}

/// @nodoc
class _$GameReviewModelCopyWithImpl<$Res, $Val extends GameReviewModel> implements $GameReviewModelCopyWith<$Res> {
  _$GameReviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? role = null, Object? rating = null, Object? comment = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            comment: null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameReviewModelImplCopyWith<$Res> implements $GameReviewModelCopyWith<$Res> {
  factory _$$GameReviewModelImplCopyWith(_$GameReviewModelImpl value, $Res Function(_$GameReviewModelImpl) then) =
      __$$GameReviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String role, double rating, String comment});
}

/// @nodoc
class __$$GameReviewModelImplCopyWithImpl<$Res> extends _$GameReviewModelCopyWithImpl<$Res, _$GameReviewModelImpl>
    implements _$$GameReviewModelImplCopyWith<$Res> {
  __$$GameReviewModelImplCopyWithImpl(_$GameReviewModelImpl _value, $Res Function(_$GameReviewModelImpl) _then)
    : super(_value, _then);

  /// Create a copy of GameReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? role = null, Object? rating = null, Object? comment = null}) {
    return _then(
      _$GameReviewModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        comment: null == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameReviewModelImpl extends _GameReviewModel {
  const _$GameReviewModelImpl({required this.name, required this.role, required this.rating, required this.comment})
    : super._();

  factory _$GameReviewModelImpl.fromJson(Map<String, dynamic> json) => _$$GameReviewModelImplFromJson(json);

  @override
  final String name;
  @override
  final String role;
  @override
  final double rating;
  @override
  final String comment;

  @override
  String toString() {
    return 'GameReviewModel(name: $name, role: $role, rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameReviewModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, role, rating, comment);

  /// Create a copy of GameReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameReviewModelImplCopyWith<_$GameReviewModelImpl> get copyWith =>
      __$$GameReviewModelImplCopyWithImpl<_$GameReviewModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameReviewModelImplToJson(this);
  }
}

abstract class _GameReviewModel extends GameReviewModel {
  const factory _GameReviewModel({
    required final String name,
    required final String role,
    required final double rating,
    required final String comment,
  }) = _$GameReviewModelImpl;
  const _GameReviewModel._() : super._();

  factory _GameReviewModel.fromJson(Map<String, dynamic> json) = _$GameReviewModelImpl.fromJson;

  @override
  String get name;
  @override
  String get role;
  @override
  double get rating;
  @override
  String get comment;

  /// Create a copy of GameReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameReviewModelImplCopyWith<_$GameReviewModelImpl> get copyWith => throw _privateConstructorUsedError;
}

GameModel _$GameModelFromJson(Map<String, dynamic> json) {
  return _GameModel.fromJson(json);
}

/// @nodoc
mixin _$GameModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviews => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  String get players => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  List<AvailabilityRangeModel>? get availability => throw _privateConstructorUsedError;

  /// `GET /api/games` returns a summary without `rules`.
  /// `GET /api/games/:id` includes `rules`.
  GameRulesModel? get rules => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviews_list')
  List<GameReviewModel> get reviewsList => throw _privateConstructorUsedError;

  /// Serializes this GameModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameModelCopyWith<GameModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameModelCopyWith<$Res> {
  factory $GameModelCopyWith(GameModel value, $Res Function(GameModel) then) = _$GameModelCopyWithImpl<$Res, GameModel>;
  @useResult
  $Res call({
    int id,
    String title,
    String category,
    String image,
    double rating,
    int reviews,
    String description,
    String duration,
    String players,
    String difficulty,
    int price,
    List<AvailabilityRangeModel>? availability,
    GameRulesModel? rules,
    @JsonKey(name: 'reviews_list') List<GameReviewModel> reviewsList,
  });

  $GameRulesModelCopyWith<$Res>? get rules;
}

/// @nodoc
class _$GameModelCopyWithImpl<$Res, $Val extends GameModel> implements $GameModelCopyWith<$Res> {
  _$GameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? category = null,
    Object? image = null,
    Object? rating = null,
    Object? reviews = null,
    Object? description = null,
    Object? duration = null,
    Object? players = null,
    Object? difficulty = null,
    Object? price = null,
    Object? availability = freezed,
    Object? rules = freezed,
    Object? reviewsList = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            image: null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviews: null == reviews
                ? _value.reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                      as int,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String,
            players: null == players
                ? _value.players
                : players // ignore: cast_nullable_to_non_nullable
                      as String,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            availability: freezed == availability
                ? _value.availability
                : availability // ignore: cast_nullable_to_non_nullable
                      as List<AvailabilityRangeModel>?,
            rules: freezed == rules
                ? _value.rules
                : rules // ignore: cast_nullable_to_non_nullable
                      as GameRulesModel?,
            reviewsList: null == reviewsList
                ? _value.reviewsList
                : reviewsList // ignore: cast_nullable_to_non_nullable
                      as List<GameReviewModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameRulesModelCopyWith<$Res>? get rules {
    if (_value.rules == null) {
      return null;
    }

    return $GameRulesModelCopyWith<$Res>(_value.rules!, (value) {
      return _then(_value.copyWith(rules: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameModelImplCopyWith<$Res> implements $GameModelCopyWith<$Res> {
  factory _$$GameModelImplCopyWith(_$GameModelImpl value, $Res Function(_$GameModelImpl) then) =
      __$$GameModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String category,
    String image,
    double rating,
    int reviews,
    String description,
    String duration,
    String players,
    String difficulty,
    int price,
    List<AvailabilityRangeModel>? availability,
    GameRulesModel? rules,
    @JsonKey(name: 'reviews_list') List<GameReviewModel> reviewsList,
  });

  @override
  $GameRulesModelCopyWith<$Res>? get rules;
}

/// @nodoc
class __$$GameModelImplCopyWithImpl<$Res> extends _$GameModelCopyWithImpl<$Res, _$GameModelImpl>
    implements _$$GameModelImplCopyWith<$Res> {
  __$$GameModelImplCopyWithImpl(_$GameModelImpl _value, $Res Function(_$GameModelImpl) _then) : super(_value, _then);

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? category = null,
    Object? image = null,
    Object? rating = null,
    Object? reviews = null,
    Object? description = null,
    Object? duration = null,
    Object? players = null,
    Object? difficulty = null,
    Object? price = null,
    Object? availability = freezed,
    Object? rules = freezed,
    Object? reviewsList = null,
  }) {
    return _then(
      _$GameModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        image: null == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviews: null == reviews
            ? _value.reviews
            : reviews // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String,
        players: null == players
            ? _value.players
            : players // ignore: cast_nullable_to_non_nullable
                  as String,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        availability: freezed == availability
            ? _value._availability
            : availability // ignore: cast_nullable_to_non_nullable
                  as List<AvailabilityRangeModel>?,
        rules: freezed == rules
            ? _value.rules
            : rules // ignore: cast_nullable_to_non_nullable
                  as GameRulesModel?,
        reviewsList: null == reviewsList
            ? _value._reviewsList
            : reviewsList // ignore: cast_nullable_to_non_nullable
                  as List<GameReviewModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameModelImpl extends _GameModel {
  const _$GameModelImpl({
    required this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.duration,
    required this.players,
    required this.difficulty,
    required this.price,
    final List<AvailabilityRangeModel>? availability,
    this.rules,
    @JsonKey(name: 'reviews_list') final List<GameReviewModel> reviewsList = const [],
  }) : _availability = availability,
       _reviewsList = reviewsList,
       super._();

  factory _$GameModelImpl.fromJson(Map<String, dynamic> json) => _$$GameModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String category;
  @override
  final String image;
  @override
  final double rating;
  @override
  final int reviews;
  @override
  final String description;
  @override
  final String duration;
  @override
  final String players;
  @override
  final String difficulty;
  @override
  final int price;
  final List<AvailabilityRangeModel>? _availability;
  @override
  List<AvailabilityRangeModel>? get availability {
    final value = _availability;
    if (value == null) return null;
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// `GET /api/games` returns a summary without `rules`.
  /// `GET /api/games/:id` includes `rules`.
  @override
  final GameRulesModel? rules;
  final List<GameReviewModel> _reviewsList;
  @override
  @JsonKey(name: 'reviews_list')
  List<GameReviewModel> get reviewsList {
    if (_reviewsList is EqualUnmodifiableListView) return _reviewsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewsList);
  }

  @override
  String toString() {
    return 'GameModel(id: $id, title: $title, category: $category, image: $image, rating: $rating, reviews: $reviews, description: $description, duration: $duration, players: $players, difficulty: $difficulty, price: $price, availability: $availability, rules: $rules, reviewsList: $reviewsList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) || other.category == category) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviews, reviews) || other.reviews == reviews) &&
            (identical(other.description, description) || other.description == description) &&
            (identical(other.duration, duration) || other.duration == duration) &&
            (identical(other.players, players) || other.players == players) &&
            (identical(other.difficulty, difficulty) || other.difficulty == difficulty) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(other._availability, _availability) &&
            (identical(other.rules, rules) || other.rules == rules) &&
            const DeepCollectionEquality().equals(other._reviewsList, _reviewsList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    category,
    image,
    rating,
    reviews,
    description,
    duration,
    players,
    difficulty,
    price,
    const DeepCollectionEquality().hash(_availability),
    rules,
    const DeepCollectionEquality().hash(_reviewsList),
  );

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameModelImplCopyWith<_$GameModelImpl> get copyWith =>
      __$$GameModelImplCopyWithImpl<_$GameModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameModelImplToJson(this);
  }
}

abstract class _GameModel extends GameModel {
  const factory _GameModel({
    required final int id,
    required final String title,
    required final String category,
    required final String image,
    required final double rating,
    required final int reviews,
    required final String description,
    required final String duration,
    required final String players,
    required final String difficulty,
    required final int price,
    final List<AvailabilityRangeModel>? availability,
    final GameRulesModel? rules,
    @JsonKey(name: 'reviews_list') final List<GameReviewModel> reviewsList,
  }) = _$GameModelImpl;
  const _GameModel._() : super._();

  factory _GameModel.fromJson(Map<String, dynamic> json) = _$GameModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get category;
  @override
  String get image;
  @override
  double get rating;
  @override
  int get reviews;
  @override
  String get description;
  @override
  String get duration;
  @override
  String get players;
  @override
  String get difficulty;
  @override
  int get price;
  @override
  List<AvailabilityRangeModel>? get availability;

  /// `GET /api/games` returns a summary without `rules`.
  /// `GET /api/games/:id` includes `rules`.
  @override
  GameRulesModel? get rules;
  @override
  @JsonKey(name: 'reviews_list')
  List<GameReviewModel> get reviewsList;

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameModelImplCopyWith<_$GameModelImpl> get copyWith => throw _privateConstructorUsedError;
}

GameCategoryModel _$GameCategoryModelFromJson(Map<String, dynamic> json) {
  return _GameCategoryModel.fromJson(json);
}

/// @nodoc
mixin _$GameCategoryModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String? get query => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this GameCategoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameCategoryModelCopyWith<GameCategoryModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCategoryModelCopyWith<$Res> {
  factory $GameCategoryModelCopyWith(GameCategoryModel value, $Res Function(GameCategoryModel) then) =
      _$GameCategoryModelCopyWithImpl<$Res, GameCategoryModel>;
  @useResult
  $Res call({int id, String name, String icon, String? query, String? description});
}

/// @nodoc
class _$GameCategoryModelCopyWithImpl<$Res, $Val extends GameCategoryModel>
    implements $GameCategoryModelCopyWith<$Res> {
  _$GameCategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? query = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            query: freezed == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameCategoryModelImplCopyWith<$Res> implements $GameCategoryModelCopyWith<$Res> {
  factory _$$GameCategoryModelImplCopyWith(_$GameCategoryModelImpl value, $Res Function(_$GameCategoryModelImpl) then) =
      __$$GameCategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String icon, String? query, String? description});
}

/// @nodoc
class __$$GameCategoryModelImplCopyWithImpl<$Res> extends _$GameCategoryModelCopyWithImpl<$Res, _$GameCategoryModelImpl>
    implements _$$GameCategoryModelImplCopyWith<$Res> {
  __$$GameCategoryModelImplCopyWithImpl(_$GameCategoryModelImpl _value, $Res Function(_$GameCategoryModelImpl) _then)
    : super(_value, _then);

  /// Create a copy of GameCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? query = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$GameCategoryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        query: freezed == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameCategoryModelImpl extends _GameCategoryModel {
  const _$GameCategoryModelImpl({
    required this.id,
    required this.name,
    required this.icon,
    this.query,
    this.description,
  }) : super._();

  factory _$GameCategoryModelImpl.fromJson(Map<String, dynamic> json) => _$$GameCategoryModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String icon;
  @override
  final String? query;
  @override
  final String? description;

  @override
  String toString() {
    return 'GameCategoryModel(id: $id, name: $name, icon: $icon, query: $query, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameCategoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.description, description) || other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, query, description);

  /// Create a copy of GameCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameCategoryModelImplCopyWith<_$GameCategoryModelImpl> get copyWith =>
      __$$GameCategoryModelImplCopyWithImpl<_$GameCategoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameCategoryModelImplToJson(this);
  }
}

abstract class _GameCategoryModel extends GameCategoryModel {
  const factory _GameCategoryModel({
    required final int id,
    required final String name,
    required final String icon,
    final String? query,
    final String? description,
  }) = _$GameCategoryModelImpl;
  const _GameCategoryModel._() : super._();

  factory _GameCategoryModel.fromJson(Map<String, dynamic> json) = _$GameCategoryModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  String? get query;
  @override
  String? get description;

  /// Create a copy of GameCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameCategoryModelImplCopyWith<_$GameCategoryModelImpl> get copyWith => throw _privateConstructorUsedError;
}

FilterShortcutModel _$FilterShortcutModelFromJson(Map<String, dynamic> json) {
  return _FilterShortcutModel.fromJson(json);
}

/// @nodoc
mixin _$FilterShortcutModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get query => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  /// Serializes this FilterShortcutModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilterShortcutModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterShortcutModelCopyWith<FilterShortcutModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterShortcutModelCopyWith<$Res> {
  factory $FilterShortcutModelCopyWith(FilterShortcutModel value, $Res Function(FilterShortcutModel) then) =
      _$FilterShortcutModelCopyWithImpl<$Res, FilterShortcutModel>;
  @useResult
  $Res call({int id, String name, String icon, String type, String? query, String? value});
}

/// @nodoc
class _$FilterShortcutModelCopyWithImpl<$Res, $Val extends FilterShortcutModel>
    implements $FilterShortcutModelCopyWith<$Res> {
  _$FilterShortcutModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterShortcutModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? type = null,
    Object? query = freezed,
    Object? value = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            query: freezed == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                      as String?,
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FilterShortcutModelImplCopyWith<$Res> implements $FilterShortcutModelCopyWith<$Res> {
  factory _$$FilterShortcutModelImplCopyWith(
    _$FilterShortcutModelImpl value,
    $Res Function(_$FilterShortcutModelImpl) then,
  ) = __$$FilterShortcutModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String icon, String type, String? query, String? value});
}

/// @nodoc
class __$$FilterShortcutModelImplCopyWithImpl<$Res>
    extends _$FilterShortcutModelCopyWithImpl<$Res, _$FilterShortcutModelImpl>
    implements _$$FilterShortcutModelImplCopyWith<$Res> {
  __$$FilterShortcutModelImplCopyWithImpl(
    _$FilterShortcutModelImpl _value,
    $Res Function(_$FilterShortcutModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FilterShortcutModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? type = null,
    Object? query = freezed,
    Object? value = freezed,
  }) {
    return _then(
      _$FilterShortcutModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        query: freezed == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String?,
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FilterShortcutModelImpl extends _FilterShortcutModel {
  const _$FilterShortcutModelImpl({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    this.query,
    this.value,
  }) : super._();

  factory _$FilterShortcutModelImpl.fromJson(Map<String, dynamic> json) => _$$FilterShortcutModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String icon;
  @override
  final String type;
  @override
  final String? query;
  @override
  final String? value;

  @override
  String toString() {
    return 'FilterShortcutModel(id: $id, name: $name, icon: $icon, type: $type, query: $query, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterShortcutModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, type, query, value);

  /// Create a copy of FilterShortcutModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterShortcutModelImplCopyWith<_$FilterShortcutModelImpl> get copyWith =>
      __$$FilterShortcutModelImplCopyWithImpl<_$FilterShortcutModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterShortcutModelImplToJson(this);
  }
}

abstract class _FilterShortcutModel extends FilterShortcutModel {
  const factory _FilterShortcutModel({
    required final int id,
    required final String name,
    required final String icon,
    required final String type,
    final String? query,
    final String? value,
  }) = _$FilterShortcutModelImpl;
  const _FilterShortcutModel._() : super._();

  factory _FilterShortcutModel.fromJson(Map<String, dynamic> json) = _$FilterShortcutModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  String get type;
  @override
  String? get query;
  @override
  String? get value;

  /// Create a copy of FilterShortcutModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterShortcutModelImplCopyWith<_$FilterShortcutModelImpl> get copyWith => throw _privateConstructorUsedError;
}
