// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ListingImageModel _$ListingImageModelFromJson(Map<String, dynamic> json) {
  return _ListingImageModel.fromJson(json);
}

/// @nodoc
mixin _$ListingImageModel {
  String get url => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;

  /// Serializes this ListingImageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingImageModelCopyWith<ListingImageModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingImageModelCopyWith<$Res> {
  factory $ListingImageModelCopyWith(ListingImageModel value, $Res Function(ListingImageModel) then) =
      _$ListingImageModelCopyWithImpl<$Res, ListingImageModel>;
  @useResult
  $Res call({String url, String type, int? width, int? height});
}

/// @nodoc
class _$ListingImageModelCopyWithImpl<$Res, $Val extends ListingImageModel>
    implements $ListingImageModelCopyWith<$Res> {
  _$ListingImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? type = null, Object? width = freezed, Object? height = freezed}) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            width: freezed == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int?,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListingImageModelImplCopyWith<$Res> implements $ListingImageModelCopyWith<$Res> {
  factory _$$ListingImageModelImplCopyWith(_$ListingImageModelImpl value, $Res Function(_$ListingImageModelImpl) then) =
      __$$ListingImageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String type, int? width, int? height});
}

/// @nodoc
class __$$ListingImageModelImplCopyWithImpl<$Res> extends _$ListingImageModelCopyWithImpl<$Res, _$ListingImageModelImpl>
    implements _$$ListingImageModelImplCopyWith<$Res> {
  __$$ListingImageModelImplCopyWithImpl(_$ListingImageModelImpl _value, $Res Function(_$ListingImageModelImpl) _then)
    : super(_value, _then);

  /// Create a copy of ListingImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? type = null, Object? width = freezed, Object? height = freezed}) {
    return _then(
      _$ListingImageModelImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        width: freezed == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingImageModelImpl extends _ListingImageModel {
  const _$ListingImageModelImpl({required this.url, required this.type, this.width, this.height}) : super._();

  factory _$ListingImageModelImpl.fromJson(Map<String, dynamic> json) => _$$ListingImageModelImplFromJson(json);

  @override
  final String url;
  @override
  final String type;
  @override
  final int? width;
  @override
  final int? height;

  @override
  String toString() {
    return 'ListingImageModel(url: $url, type: $type, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingImageModelImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, type, width, height);

  /// Create a copy of ListingImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingImageModelImplCopyWith<_$ListingImageModelImpl> get copyWith =>
      __$$ListingImageModelImplCopyWithImpl<_$ListingImageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingImageModelImplToJson(this);
  }
}

abstract class _ListingImageModel extends ListingImageModel {
  const factory _ListingImageModel({
    required final String url,
    required final String type,
    final int? width,
    final int? height,
  }) = _$ListingImageModelImpl;
  const _ListingImageModel._() : super._();

  factory _ListingImageModel.fromJson(Map<String, dynamic> json) = _$ListingImageModelImpl.fromJson;

  @override
  String get url;
  @override
  String get type;
  @override
  int? get width;
  @override
  int? get height;

  /// Create a copy of ListingImageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingImageModelImplCopyWith<_$ListingImageModelImpl> get copyWith => throw _privateConstructorUsedError;
}

ListingModel _$ListingModelFromJson(Map<String, dynamic> json) {
  return _ListingModel.fromJson(json);
}

/// @nodoc
mixin _$ListingModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get publisher => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  int? get reviews => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  String? get players => throw _privateConstructorUsedError;
  String? get difficulty => throw _privateConstructorUsedError;
  @JsonKey(name: 'pricePerDay')
  int get pricePerDay => throw _privateConstructorUsedError;
  int? get deposit => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String get visibility => throw _privateConstructorUsedError;
  @JsonKey(name: 'ownerId')
  String get ownerId => throw _privateConstructorUsedError;
  List<ListingImageModel> get images => throw _privateConstructorUsedError;

  /// Serializes this ListingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingModelCopyWith<ListingModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingModelCopyWith<$Res> {
  factory $ListingModelCopyWith(ListingModel value, $Res Function(ListingModel) then) =
      _$ListingModelCopyWithImpl<$Res, ListingModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String? publisher,
    String category,
    String description,
    double? rating,
    int? reviews,
    String? duration,
    String? players,
    String? difficulty,
    @JsonKey(name: 'pricePerDay') int pricePerDay,
    int? deposit,
    String condition,
    String visibility,
    @JsonKey(name: 'ownerId') String ownerId,
    List<ListingImageModel> images,
  });
}

/// @nodoc
class _$ListingModelCopyWithImpl<$Res, $Val extends ListingModel> implements $ListingModelCopyWith<$Res> {
  _$ListingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? publisher = freezed,
    Object? category = null,
    Object? description = null,
    Object? rating = freezed,
    Object? reviews = freezed,
    Object? duration = freezed,
    Object? players = freezed,
    Object? difficulty = freezed,
    Object? pricePerDay = null,
    Object? deposit = freezed,
    Object? condition = null,
    Object? visibility = null,
    Object? ownerId = null,
    Object? images = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            publisher: freezed == publisher
                ? _value.publisher
                : publisher // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double?,
            reviews: freezed == reviews
                ? _value.reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                      as int?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String?,
            players: freezed == players
                ? _value.players
                : players // ignore: cast_nullable_to_non_nullable
                      as String?,
            difficulty: freezed == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String?,
            pricePerDay: null == pricePerDay
                ? _value.pricePerDay
                : pricePerDay // ignore: cast_nullable_to_non_nullable
                      as int,
            deposit: freezed == deposit
                ? _value.deposit
                : deposit // ignore: cast_nullable_to_non_nullable
                      as int?,
            condition: null == condition
                ? _value.condition
                : condition // ignore: cast_nullable_to_non_nullable
                      as String,
            visibility: null == visibility
                ? _value.visibility
                : visibility // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerId: null == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as String,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<ListingImageModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListingModelImplCopyWith<$Res> implements $ListingModelCopyWith<$Res> {
  factory _$$ListingModelImplCopyWith(_$ListingModelImpl value, $Res Function(_$ListingModelImpl) then) =
      __$$ListingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? publisher,
    String category,
    String description,
    double? rating,
    int? reviews,
    String? duration,
    String? players,
    String? difficulty,
    @JsonKey(name: 'pricePerDay') int pricePerDay,
    int? deposit,
    String condition,
    String visibility,
    @JsonKey(name: 'ownerId') String ownerId,
    List<ListingImageModel> images,
  });
}

/// @nodoc
class __$$ListingModelImplCopyWithImpl<$Res> extends _$ListingModelCopyWithImpl<$Res, _$ListingModelImpl>
    implements _$$ListingModelImplCopyWith<$Res> {
  __$$ListingModelImplCopyWithImpl(_$ListingModelImpl _value, $Res Function(_$ListingModelImpl) _then)
    : super(_value, _then);

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? publisher = freezed,
    Object? category = null,
    Object? description = null,
    Object? rating = freezed,
    Object? reviews = freezed,
    Object? duration = freezed,
    Object? players = freezed,
    Object? difficulty = freezed,
    Object? pricePerDay = null,
    Object? deposit = freezed,
    Object? condition = null,
    Object? visibility = null,
    Object? ownerId = null,
    Object? images = null,
  }) {
    return _then(
      _$ListingModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        publisher: freezed == publisher
            ? _value.publisher
            : publisher // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: freezed == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double?,
        reviews: freezed == reviews
            ? _value.reviews
            : reviews // ignore: cast_nullable_to_non_nullable
                  as int?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String?,
        players: freezed == players
            ? _value.players
            : players // ignore: cast_nullable_to_non_nullable
                  as String?,
        difficulty: freezed == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String?,
        pricePerDay: null == pricePerDay
            ? _value.pricePerDay
            : pricePerDay // ignore: cast_nullable_to_non_nullable
                  as int,
        deposit: freezed == deposit
            ? _value.deposit
            : deposit // ignore: cast_nullable_to_non_nullable
                  as int?,
        condition: null == condition
            ? _value.condition
            : condition // ignore: cast_nullable_to_non_nullable
                  as String,
        visibility: null == visibility
            ? _value.visibility
            : visibility // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerId: null == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as String,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<ListingImageModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingModelImpl extends _ListingModel {
  const _$ListingModelImpl({
    required this.id,
    required this.title,
    this.publisher,
    required this.category,
    required this.description,
    this.rating,
    this.reviews,
    this.duration,
    this.players,
    this.difficulty,
    @JsonKey(name: 'pricePerDay') required this.pricePerDay,
    this.deposit,
    required this.condition,
    required this.visibility,
    @JsonKey(name: 'ownerId') required this.ownerId,
    final List<ListingImageModel> images = const [],
  }) : _images = images,
       super._();

  factory _$ListingModelImpl.fromJson(Map<String, dynamic> json) => _$$ListingModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? publisher;
  @override
  final String category;
  @override
  final String description;
  @override
  final double? rating;
  @override
  final int? reviews;
  @override
  final String? duration;
  @override
  final String? players;
  @override
  final String? difficulty;
  @override
  @JsonKey(name: 'pricePerDay')
  final int pricePerDay;
  @override
  final int? deposit;
  @override
  final String condition;
  @override
  final String visibility;
  @override
  @JsonKey(name: 'ownerId')
  final String ownerId;
  final List<ListingImageModel> _images;
  @override
  @JsonKey()
  List<ListingImageModel> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'ListingModel(id: $id, title: $title, publisher: $publisher, category: $category, description: $description, rating: $rating, reviews: $reviews, duration: $duration, players: $players, difficulty: $difficulty, pricePerDay: $pricePerDay, deposit: $deposit, condition: $condition, visibility: $visibility, ownerId: $ownerId, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.publisher, publisher) || other.publisher == publisher) &&
            (identical(other.category, category) || other.category == category) &&
            (identical(other.description, description) || other.description == description) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviews, reviews) || other.reviews == reviews) &&
            (identical(other.duration, duration) || other.duration == duration) &&
            (identical(other.players, players) || other.players == players) &&
            (identical(other.difficulty, difficulty) || other.difficulty == difficulty) &&
            (identical(other.pricePerDay, pricePerDay) || other.pricePerDay == pricePerDay) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.condition, condition) || other.condition == condition) &&
            (identical(other.visibility, visibility) || other.visibility == visibility) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    publisher,
    category,
    description,
    rating,
    reviews,
    duration,
    players,
    difficulty,
    pricePerDay,
    deposit,
    condition,
    visibility,
    ownerId,
    const DeepCollectionEquality().hash(_images),
  );

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingModelImplCopyWith<_$ListingModelImpl> get copyWith =>
      __$$ListingModelImplCopyWithImpl<_$ListingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingModelImplToJson(this);
  }
}

abstract class _ListingModel extends ListingModel {
  const factory _ListingModel({
    required final String id,
    required final String title,
    final String? publisher,
    required final String category,
    required final String description,
    final double? rating,
    final int? reviews,
    final String? duration,
    final String? players,
    final String? difficulty,
    @JsonKey(name: 'pricePerDay') required final int pricePerDay,
    final int? deposit,
    required final String condition,
    required final String visibility,
    @JsonKey(name: 'ownerId') required final String ownerId,
    final List<ListingImageModel> images,
  }) = _$ListingModelImpl;
  const _ListingModel._() : super._();

  factory _ListingModel.fromJson(Map<String, dynamic> json) = _$ListingModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get publisher;
  @override
  String get category;
  @override
  String get description;
  @override
  double? get rating;
  @override
  int? get reviews;
  @override
  String? get duration;
  @override
  String? get players;
  @override
  String? get difficulty;
  @override
  @JsonKey(name: 'pricePerDay')
  int get pricePerDay;
  @override
  int? get deposit;
  @override
  String get condition;
  @override
  String get visibility;
  @override
  @JsonKey(name: 'ownerId')
  String get ownerId;
  @override
  List<ListingImageModel> get images;

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingModelImplCopyWith<_$ListingModelImpl> get copyWith => throw _privateConstructorUsedError;
}

ListingCreateRequestModel _$ListingCreateRequestModelFromJson(Map<String, dynamic> json) {
  return _ListingCreateRequestModel.fromJson(json);
}

/// @nodoc
mixin _$ListingCreateRequestModel {
  String get title => throw _privateConstructorUsedError;
  String? get publisher => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  String? get players => throw _privateConstructorUsedError;
  String? get difficulty => throw _privateConstructorUsedError;
  @JsonKey(name: 'pricePerDay')
  int get pricePerDay => throw _privateConstructorUsedError;
  int? get deposit => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String get visibility => throw _privateConstructorUsedError;
  List<ListingImageModel> get images => throw _privateConstructorUsedError;

  /// Serializes this ListingCreateRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingCreateRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingCreateRequestModelCopyWith<ListingCreateRequestModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingCreateRequestModelCopyWith<$Res> {
  factory $ListingCreateRequestModelCopyWith(
    ListingCreateRequestModel value,
    $Res Function(ListingCreateRequestModel) then,
  ) = _$ListingCreateRequestModelCopyWithImpl<$Res, ListingCreateRequestModel>;
  @useResult
  $Res call({
    String title,
    String? publisher,
    String category,
    String description,
    String? duration,
    String? players,
    String? difficulty,
    @JsonKey(name: 'pricePerDay') int pricePerDay,
    int? deposit,
    String condition,
    String visibility,
    List<ListingImageModel> images,
  });
}

/// @nodoc
class _$ListingCreateRequestModelCopyWithImpl<$Res, $Val extends ListingCreateRequestModel>
    implements $ListingCreateRequestModelCopyWith<$Res> {
  _$ListingCreateRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingCreateRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? publisher = freezed,
    Object? category = null,
    Object? description = null,
    Object? duration = freezed,
    Object? players = freezed,
    Object? difficulty = freezed,
    Object? pricePerDay = null,
    Object? deposit = freezed,
    Object? condition = null,
    Object? visibility = null,
    Object? images = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            publisher: freezed == publisher
                ? _value.publisher
                : publisher // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String?,
            players: freezed == players
                ? _value.players
                : players // ignore: cast_nullable_to_non_nullable
                      as String?,
            difficulty: freezed == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String?,
            pricePerDay: null == pricePerDay
                ? _value.pricePerDay
                : pricePerDay // ignore: cast_nullable_to_non_nullable
                      as int,
            deposit: freezed == deposit
                ? _value.deposit
                : deposit // ignore: cast_nullable_to_non_nullable
                      as int?,
            condition: null == condition
                ? _value.condition
                : condition // ignore: cast_nullable_to_non_nullable
                      as String,
            visibility: null == visibility
                ? _value.visibility
                : visibility // ignore: cast_nullable_to_non_nullable
                      as String,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<ListingImageModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListingCreateRequestModelImplCopyWith<$Res> implements $ListingCreateRequestModelCopyWith<$Res> {
  factory _$$ListingCreateRequestModelImplCopyWith(
    _$ListingCreateRequestModelImpl value,
    $Res Function(_$ListingCreateRequestModelImpl) then,
  ) = __$$ListingCreateRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String? publisher,
    String category,
    String description,
    String? duration,
    String? players,
    String? difficulty,
    @JsonKey(name: 'pricePerDay') int pricePerDay,
    int? deposit,
    String condition,
    String visibility,
    List<ListingImageModel> images,
  });
}

/// @nodoc
class __$$ListingCreateRequestModelImplCopyWithImpl<$Res>
    extends _$ListingCreateRequestModelCopyWithImpl<$Res, _$ListingCreateRequestModelImpl>
    implements _$$ListingCreateRequestModelImplCopyWith<$Res> {
  __$$ListingCreateRequestModelImplCopyWithImpl(
    _$ListingCreateRequestModelImpl _value,
    $Res Function(_$ListingCreateRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ListingCreateRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? publisher = freezed,
    Object? category = null,
    Object? description = null,
    Object? duration = freezed,
    Object? players = freezed,
    Object? difficulty = freezed,
    Object? pricePerDay = null,
    Object? deposit = freezed,
    Object? condition = null,
    Object? visibility = null,
    Object? images = null,
  }) {
    return _then(
      _$ListingCreateRequestModelImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        publisher: freezed == publisher
            ? _value.publisher
            : publisher // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String?,
        players: freezed == players
            ? _value.players
            : players // ignore: cast_nullable_to_non_nullable
                  as String?,
        difficulty: freezed == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String?,
        pricePerDay: null == pricePerDay
            ? _value.pricePerDay
            : pricePerDay // ignore: cast_nullable_to_non_nullable
                  as int,
        deposit: freezed == deposit
            ? _value.deposit
            : deposit // ignore: cast_nullable_to_non_nullable
                  as int?,
        condition: null == condition
            ? _value.condition
            : condition // ignore: cast_nullable_to_non_nullable
                  as String,
        visibility: null == visibility
            ? _value.visibility
            : visibility // ignore: cast_nullable_to_non_nullable
                  as String,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<ListingImageModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingCreateRequestModelImpl extends _ListingCreateRequestModel {
  const _$ListingCreateRequestModelImpl({
    required this.title,
    this.publisher,
    required this.category,
    required this.description,
    this.duration,
    this.players,
    this.difficulty,
    @JsonKey(name: 'pricePerDay') required this.pricePerDay,
    this.deposit,
    required this.condition,
    required this.visibility,
    required final List<ListingImageModel> images,
  }) : _images = images,
       super._();

  factory _$ListingCreateRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingCreateRequestModelImplFromJson(json);

  @override
  final String title;
  @override
  final String? publisher;
  @override
  final String category;
  @override
  final String description;
  @override
  final String? duration;
  @override
  final String? players;
  @override
  final String? difficulty;
  @override
  @JsonKey(name: 'pricePerDay')
  final int pricePerDay;
  @override
  final int? deposit;
  @override
  final String condition;
  @override
  final String visibility;
  final List<ListingImageModel> _images;
  @override
  List<ListingImageModel> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'ListingCreateRequestModel(title: $title, publisher: $publisher, category: $category, description: $description, duration: $duration, players: $players, difficulty: $difficulty, pricePerDay: $pricePerDay, deposit: $deposit, condition: $condition, visibility: $visibility, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingCreateRequestModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.publisher, publisher) || other.publisher == publisher) &&
            (identical(other.category, category) || other.category == category) &&
            (identical(other.description, description) || other.description == description) &&
            (identical(other.duration, duration) || other.duration == duration) &&
            (identical(other.players, players) || other.players == players) &&
            (identical(other.difficulty, difficulty) || other.difficulty == difficulty) &&
            (identical(other.pricePerDay, pricePerDay) || other.pricePerDay == pricePerDay) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.condition, condition) || other.condition == condition) &&
            (identical(other.visibility, visibility) || other.visibility == visibility) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    publisher,
    category,
    description,
    duration,
    players,
    difficulty,
    pricePerDay,
    deposit,
    condition,
    visibility,
    const DeepCollectionEquality().hash(_images),
  );

  /// Create a copy of ListingCreateRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingCreateRequestModelImplCopyWith<_$ListingCreateRequestModelImpl> get copyWith =>
      __$$ListingCreateRequestModelImplCopyWithImpl<_$ListingCreateRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingCreateRequestModelImplToJson(this);
  }
}

abstract class _ListingCreateRequestModel extends ListingCreateRequestModel {
  const factory _ListingCreateRequestModel({
    required final String title,
    final String? publisher,
    required final String category,
    required final String description,
    final String? duration,
    final String? players,
    final String? difficulty,
    @JsonKey(name: 'pricePerDay') required final int pricePerDay,
    final int? deposit,
    required final String condition,
    required final String visibility,
    required final List<ListingImageModel> images,
  }) = _$ListingCreateRequestModelImpl;
  const _ListingCreateRequestModel._() : super._();

  factory _ListingCreateRequestModel.fromJson(Map<String, dynamic> json) = _$ListingCreateRequestModelImpl.fromJson;

  @override
  String get title;
  @override
  String? get publisher;
  @override
  String get category;
  @override
  String get description;
  @override
  String? get duration;
  @override
  String? get players;
  @override
  String? get difficulty;
  @override
  @JsonKey(name: 'pricePerDay')
  int get pricePerDay;
  @override
  int? get deposit;
  @override
  String get condition;
  @override
  String get visibility;
  @override
  List<ListingImageModel> get images;

  /// Create a copy of ListingCreateRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingCreateRequestModelImplCopyWith<_$ListingCreateRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
