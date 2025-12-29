// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ListingImage {
  String get url => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;

  /// Create a copy of ListingImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingImageCopyWith<ListingImage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingImageCopyWith<$Res> {
  factory $ListingImageCopyWith(ListingImage value, $Res Function(ListingImage) then) =
      _$ListingImageCopyWithImpl<$Res, ListingImage>;
  @useResult
  $Res call({String url, String type, int? width, int? height});
}

/// @nodoc
class _$ListingImageCopyWithImpl<$Res, $Val extends ListingImage> implements $ListingImageCopyWith<$Res> {
  _$ListingImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingImage
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
abstract class _$$ListingImageImplCopyWith<$Res> implements $ListingImageCopyWith<$Res> {
  factory _$$ListingImageImplCopyWith(_$ListingImageImpl value, $Res Function(_$ListingImageImpl) then) =
      __$$ListingImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String type, int? width, int? height});
}

/// @nodoc
class __$$ListingImageImplCopyWithImpl<$Res> extends _$ListingImageCopyWithImpl<$Res, _$ListingImageImpl>
    implements _$$ListingImageImplCopyWith<$Res> {
  __$$ListingImageImplCopyWithImpl(_$ListingImageImpl _value, $Res Function(_$ListingImageImpl) _then)
    : super(_value, _then);

  /// Create a copy of ListingImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? type = null, Object? width = freezed, Object? height = freezed}) {
    return _then(
      _$ListingImageImpl(
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

class _$ListingImageImpl implements _ListingImage {
  const _$ListingImageImpl({required this.url, required this.type, this.width, this.height});

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
    return 'ListingImage(url: $url, type: $type, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingImageImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, type, width, height);

  /// Create a copy of ListingImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingImageImplCopyWith<_$ListingImageImpl> get copyWith =>
      __$$ListingImageImplCopyWithImpl<_$ListingImageImpl>(this, _$identity);
}

abstract class _ListingImage implements ListingImage {
  const factory _ListingImage({
    required final String url,
    required final String type,
    final int? width,
    final int? height,
  }) = _$ListingImageImpl;

  @override
  String get url;
  @override
  String get type;
  @override
  int? get width;
  @override
  int? get height;

  /// Create a copy of ListingImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingImageImplCopyWith<_$ListingImageImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ListingDraft {
  String get title => throw _privateConstructorUsedError;
  String? get publisher => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  String? get players => throw _privateConstructorUsedError;
  String? get difficulty => throw _privateConstructorUsedError;
  int get pricePerDay => throw _privateConstructorUsedError;
  int? get deposit => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String get visibility => throw _privateConstructorUsedError;
  List<ListingImage> get images => throw _privateConstructorUsedError;

  /// Create a copy of ListingDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingDraftCopyWith<ListingDraft> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingDraftCopyWith<$Res> {
  factory $ListingDraftCopyWith(ListingDraft value, $Res Function(ListingDraft) then) =
      _$ListingDraftCopyWithImpl<$Res, ListingDraft>;
  @useResult
  $Res call({
    String title,
    String? publisher,
    String category,
    String description,
    String? duration,
    String? players,
    String? difficulty,
    int pricePerDay,
    int? deposit,
    String condition,
    String visibility,
    List<ListingImage> images,
  });
}

/// @nodoc
class _$ListingDraftCopyWithImpl<$Res, $Val extends ListingDraft> implements $ListingDraftCopyWith<$Res> {
  _$ListingDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingDraft
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
                      as List<ListingImage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListingDraftImplCopyWith<$Res> implements $ListingDraftCopyWith<$Res> {
  factory _$$ListingDraftImplCopyWith(_$ListingDraftImpl value, $Res Function(_$ListingDraftImpl) then) =
      __$$ListingDraftImplCopyWithImpl<$Res>;
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
    int pricePerDay,
    int? deposit,
    String condition,
    String visibility,
    List<ListingImage> images,
  });
}

/// @nodoc
class __$$ListingDraftImplCopyWithImpl<$Res> extends _$ListingDraftCopyWithImpl<$Res, _$ListingDraftImpl>
    implements _$$ListingDraftImplCopyWith<$Res> {
  __$$ListingDraftImplCopyWithImpl(_$ListingDraftImpl _value, $Res Function(_$ListingDraftImpl) _then)
    : super(_value, _then);

  /// Create a copy of ListingDraft
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
      _$ListingDraftImpl(
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
                  as List<ListingImage>,
      ),
    );
  }
}

/// @nodoc

class _$ListingDraftImpl implements _ListingDraft {
  const _$ListingDraftImpl({
    required this.title,
    this.publisher,
    required this.category,
    required this.description,
    this.duration,
    this.players,
    this.difficulty,
    required this.pricePerDay,
    this.deposit,
    required this.condition,
    required this.visibility,
    required final List<ListingImage> images,
  }) : _images = images;

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
  final int pricePerDay;
  @override
  final int? deposit;
  @override
  final String condition;
  @override
  final String visibility;
  final List<ListingImage> _images;
  @override
  List<ListingImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'ListingDraft(title: $title, publisher: $publisher, category: $category, description: $description, duration: $duration, players: $players, difficulty: $difficulty, pricePerDay: $pricePerDay, deposit: $deposit, condition: $condition, visibility: $visibility, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingDraftImpl &&
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

  /// Create a copy of ListingDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingDraftImplCopyWith<_$ListingDraftImpl> get copyWith =>
      __$$ListingDraftImplCopyWithImpl<_$ListingDraftImpl>(this, _$identity);
}

abstract class _ListingDraft implements ListingDraft {
  const factory _ListingDraft({
    required final String title,
    final String? publisher,
    required final String category,
    required final String description,
    final String? duration,
    final String? players,
    final String? difficulty,
    required final int pricePerDay,
    final int? deposit,
    required final String condition,
    required final String visibility,
    required final List<ListingImage> images,
  }) = _$ListingDraftImpl;

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
  int get pricePerDay;
  @override
  int? get deposit;
  @override
  String get condition;
  @override
  String get visibility;
  @override
  List<ListingImage> get images;

  /// Create a copy of ListingDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingDraftImplCopyWith<_$ListingDraftImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Listing {
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
  int get pricePerDay => throw _privateConstructorUsedError;
  int? get deposit => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String get visibility => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  List<ListingImage> get images => throw _privateConstructorUsedError;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingCopyWith<Listing> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingCopyWith<$Res> {
  factory $ListingCopyWith(Listing value, $Res Function(Listing) then) = _$ListingCopyWithImpl<$Res, Listing>;
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
    int pricePerDay,
    int? deposit,
    String condition,
    String visibility,
    String ownerId,
    List<ListingImage> images,
  });
}

/// @nodoc
class _$ListingCopyWithImpl<$Res, $Val extends Listing> implements $ListingCopyWith<$Res> {
  _$ListingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Listing
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
                      as List<ListingImage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListingImplCopyWith<$Res> implements $ListingCopyWith<$Res> {
  factory _$$ListingImplCopyWith(_$ListingImpl value, $Res Function(_$ListingImpl) then) =
      __$$ListingImplCopyWithImpl<$Res>;
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
    int pricePerDay,
    int? deposit,
    String condition,
    String visibility,
    String ownerId,
    List<ListingImage> images,
  });
}

/// @nodoc
class __$$ListingImplCopyWithImpl<$Res> extends _$ListingCopyWithImpl<$Res, _$ListingImpl>
    implements _$$ListingImplCopyWith<$Res> {
  __$$ListingImplCopyWithImpl(_$ListingImpl _value, $Res Function(_$ListingImpl) _then) : super(_value, _then);

  /// Create a copy of Listing
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
      _$ListingImpl(
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
                  as List<ListingImage>,
      ),
    );
  }
}

/// @nodoc

class _$ListingImpl implements _Listing {
  const _$ListingImpl({
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
    required this.pricePerDay,
    this.deposit,
    required this.condition,
    required this.visibility,
    required this.ownerId,
    final List<ListingImage> images = const [],
  }) : _images = images;

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
  final int pricePerDay;
  @override
  final int? deposit;
  @override
  final String condition;
  @override
  final String visibility;
  @override
  final String ownerId;
  final List<ListingImage> _images;
  @override
  @JsonKey()
  List<ListingImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'Listing(id: $id, title: $title, publisher: $publisher, category: $category, description: $description, rating: $rating, reviews: $reviews, duration: $duration, players: $players, difficulty: $difficulty, pricePerDay: $pricePerDay, deposit: $deposit, condition: $condition, visibility: $visibility, ownerId: $ownerId, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingImpl &&
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

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingImplCopyWith<_$ListingImpl> get copyWith => __$$ListingImplCopyWithImpl<_$ListingImpl>(this, _$identity);
}

abstract class _Listing implements Listing {
  const factory _Listing({
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
    required final int pricePerDay,
    final int? deposit,
    required final String condition,
    required final String visibility,
    required final String ownerId,
    final List<ListingImage> images,
  }) = _$ListingImpl;

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
  int get pricePerDay;
  @override
  int? get deposit;
  @override
  String get condition;
  @override
  String get visibility;
  @override
  String get ownerId;
  @override
  List<ListingImage> get images;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingImplCopyWith<_$ListingImpl> get copyWith => throw _privateConstructorUsedError;
}
