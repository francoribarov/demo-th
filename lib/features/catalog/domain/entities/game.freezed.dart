// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AvailabilityRange {
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;

  /// Create a copy of AvailabilityRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailabilityRangeCopyWith<AvailabilityRange> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailabilityRangeCopyWith<$Res> {
  factory $AvailabilityRangeCopyWith(AvailabilityRange value, $Res Function(AvailabilityRange) then) =
      _$AvailabilityRangeCopyWithImpl<$Res, AvailabilityRange>;
  @useResult
  $Res call({String from, String to});
}

/// @nodoc
class _$AvailabilityRangeCopyWithImpl<$Res, $Val extends AvailabilityRange>
    implements $AvailabilityRangeCopyWith<$Res> {
  _$AvailabilityRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailabilityRange
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
abstract class _$$AvailabilityRangeImplCopyWith<$Res> implements $AvailabilityRangeCopyWith<$Res> {
  factory _$$AvailabilityRangeImplCopyWith(_$AvailabilityRangeImpl value, $Res Function(_$AvailabilityRangeImpl) then) =
      __$$AvailabilityRangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String from, String to});
}

/// @nodoc
class __$$AvailabilityRangeImplCopyWithImpl<$Res> extends _$AvailabilityRangeCopyWithImpl<$Res, _$AvailabilityRangeImpl>
    implements _$$AvailabilityRangeImplCopyWith<$Res> {
  __$$AvailabilityRangeImplCopyWithImpl(_$AvailabilityRangeImpl _value, $Res Function(_$AvailabilityRangeImpl) _then)
    : super(_value, _then);

  /// Create a copy of AvailabilityRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? from = null, Object? to = null}) {
    return _then(
      _$AvailabilityRangeImpl(
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

class _$AvailabilityRangeImpl implements _AvailabilityRange {
  const _$AvailabilityRangeImpl({required this.from, required this.to});

  @override
  final String from;
  @override
  final String to;

  @override
  String toString() {
    return 'AvailabilityRange(from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailabilityRangeImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @override
  int get hashCode => Object.hash(runtimeType, from, to);

  /// Create a copy of AvailabilityRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailabilityRangeImplCopyWith<_$AvailabilityRangeImpl> get copyWith =>
      __$$AvailabilityRangeImplCopyWithImpl<_$AvailabilityRangeImpl>(this, _$identity);
}

abstract class _AvailabilityRange implements AvailabilityRange {
  const factory _AvailabilityRange({required final String from, required final String to}) = _$AvailabilityRangeImpl;

  @override
  String get from;
  @override
  String get to;

  /// Create a copy of AvailabilityRange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailabilityRangeImplCopyWith<_$AvailabilityRangeImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GameRules {
  String get video => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  /// Create a copy of GameRules
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameRulesCopyWith<GameRules> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRulesCopyWith<$Res> {
  factory $GameRulesCopyWith(GameRules value, $Res Function(GameRules) then) = _$GameRulesCopyWithImpl<$Res, GameRules>;
  @useResult
  $Res call({String video, String text});
}

/// @nodoc
class _$GameRulesCopyWithImpl<$Res, $Val extends GameRules> implements $GameRulesCopyWith<$Res> {
  _$GameRulesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameRules
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
abstract class _$$GameRulesImplCopyWith<$Res> implements $GameRulesCopyWith<$Res> {
  factory _$$GameRulesImplCopyWith(_$GameRulesImpl value, $Res Function(_$GameRulesImpl) then) =
      __$$GameRulesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String video, String text});
}

/// @nodoc
class __$$GameRulesImplCopyWithImpl<$Res> extends _$GameRulesCopyWithImpl<$Res, _$GameRulesImpl>
    implements _$$GameRulesImplCopyWith<$Res> {
  __$$GameRulesImplCopyWithImpl(_$GameRulesImpl _value, $Res Function(_$GameRulesImpl) _then) : super(_value, _then);

  /// Create a copy of GameRules
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? video = null, Object? text = null}) {
    return _then(
      _$GameRulesImpl(
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

class _$GameRulesImpl implements _GameRules {
  const _$GameRulesImpl({required this.video, required this.text});

  @override
  final String video;
  @override
  final String text;

  @override
  String toString() {
    return 'GameRules(video: $video, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameRulesImpl &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, video, text);

  /// Create a copy of GameRules
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameRulesImplCopyWith<_$GameRulesImpl> get copyWith =>
      __$$GameRulesImplCopyWithImpl<_$GameRulesImpl>(this, _$identity);
}

abstract class _GameRules implements GameRules {
  const factory _GameRules({required final String video, required final String text}) = _$GameRulesImpl;

  @override
  String get video;
  @override
  String get text;

  /// Create a copy of GameRules
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameRulesImplCopyWith<_$GameRulesImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GameReview {
  String get name => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;

  /// Create a copy of GameReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameReviewCopyWith<GameReview> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameReviewCopyWith<$Res> {
  factory $GameReviewCopyWith(GameReview value, $Res Function(GameReview) then) =
      _$GameReviewCopyWithImpl<$Res, GameReview>;
  @useResult
  $Res call({String name, String role, double rating, String comment});
}

/// @nodoc
class _$GameReviewCopyWithImpl<$Res, $Val extends GameReview> implements $GameReviewCopyWith<$Res> {
  _$GameReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameReview
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
abstract class _$$GameReviewImplCopyWith<$Res> implements $GameReviewCopyWith<$Res> {
  factory _$$GameReviewImplCopyWith(_$GameReviewImpl value, $Res Function(_$GameReviewImpl) then) =
      __$$GameReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String role, double rating, String comment});
}

/// @nodoc
class __$$GameReviewImplCopyWithImpl<$Res> extends _$GameReviewCopyWithImpl<$Res, _$GameReviewImpl>
    implements _$$GameReviewImplCopyWith<$Res> {
  __$$GameReviewImplCopyWithImpl(_$GameReviewImpl _value, $Res Function(_$GameReviewImpl) _then) : super(_value, _then);

  /// Create a copy of GameReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? role = null, Object? rating = null, Object? comment = null}) {
    return _then(
      _$GameReviewImpl(
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

class _$GameReviewImpl implements _GameReview {
  const _$GameReviewImpl({required this.name, required this.role, required this.rating, required this.comment});

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
    return 'GameReview(name: $name, role: $role, rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameReviewImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, role, rating, comment);

  /// Create a copy of GameReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameReviewImplCopyWith<_$GameReviewImpl> get copyWith =>
      __$$GameReviewImplCopyWithImpl<_$GameReviewImpl>(this, _$identity);
}

abstract class _GameReview implements GameReview {
  const factory _GameReview({
    required final String name,
    required final String role,
    required final double rating,
    required final String comment,
  }) = _$GameReviewImpl;

  @override
  String get name;
  @override
  String get role;
  @override
  double get rating;
  @override
  String get comment;

  /// Create a copy of GameReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameReviewImplCopyWith<_$GameReviewImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Game {
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
  List<AvailabilityRange>? get availability => throw _privateConstructorUsedError;
  GameRules get rules => throw _privateConstructorUsedError;
  List<GameReview> get reviewsList => throw _privateConstructorUsedError;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) = _$GameCopyWithImpl<$Res, Game>;
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
    List<AvailabilityRange>? availability,
    GameRules rules,
    List<GameReview> reviewsList,
  });

  $GameRulesCopyWith<$Res> get rules;
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game> implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Game
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
    Object? rules = null,
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
                      as List<AvailabilityRange>?,
            rules: null == rules
                ? _value.rules
                : rules // ignore: cast_nullable_to_non_nullable
                      as GameRules,
            reviewsList: null == reviewsList
                ? _value.reviewsList
                : reviewsList // ignore: cast_nullable_to_non_nullable
                      as List<GameReview>,
          )
          as $Val,
    );
  }

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameRulesCopyWith<$Res> get rules {
    return $GameRulesCopyWith<$Res>(_value.rules, (value) {
      return _then(_value.copyWith(rules: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(_$GameImpl value, $Res Function(_$GameImpl) then) = __$$GameImplCopyWithImpl<$Res>;
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
    List<AvailabilityRange>? availability,
    GameRules rules,
    List<GameReview> reviewsList,
  });

  @override
  $GameRulesCopyWith<$Res> get rules;
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res, _$GameImpl> implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then) : super(_value, _then);

  /// Create a copy of Game
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
    Object? rules = null,
    Object? reviewsList = null,
  }) {
    return _then(
      _$GameImpl(
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
                  as List<AvailabilityRange>?,
        rules: null == rules
            ? _value.rules
            : rules // ignore: cast_nullable_to_non_nullable
                  as GameRules,
        reviewsList: null == reviewsList
            ? _value._reviewsList
            : reviewsList // ignore: cast_nullable_to_non_nullable
                  as List<GameReview>,
      ),
    );
  }
}

/// @nodoc

class _$GameImpl extends _Game {
  const _$GameImpl({
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
    final List<AvailabilityRange>? availability,
    required this.rules,
    final List<GameReview> reviewsList = const [],
  }) : _availability = availability,
       _reviewsList = reviewsList,
       super._();

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
  final List<AvailabilityRange>? _availability;
  @override
  List<AvailabilityRange>? get availability {
    final value = _availability;
    if (value == null) return null;
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final GameRules rules;
  final List<GameReview> _reviewsList;
  @override
  @JsonKey()
  List<GameReview> get reviewsList {
    if (_reviewsList is EqualUnmodifiableListView) return _reviewsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewsList);
  }

  @override
  String toString() {
    return 'Game(id: $id, title: $title, category: $category, image: $image, rating: $rating, reviews: $reviews, description: $description, duration: $duration, players: $players, difficulty: $difficulty, price: $price, availability: $availability, rules: $rules, reviewsList: $reviewsList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
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

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith => __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);
}

abstract class _Game extends Game {
  const factory _Game({
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
    final List<AvailabilityRange>? availability,
    required final GameRules rules,
    final List<GameReview> reviewsList,
  }) = _$GameImpl;
  const _Game._() : super._();

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
  List<AvailabilityRange>? get availability;
  @override
  GameRules get rules;
  @override
  List<GameReview> get reviewsList;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameImplCopyWith<_$GameImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GameCategory {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String? get query => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Create a copy of GameCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameCategoryCopyWith<GameCategory> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCategoryCopyWith<$Res> {
  factory $GameCategoryCopyWith(GameCategory value, $Res Function(GameCategory) then) =
      _$GameCategoryCopyWithImpl<$Res, GameCategory>;
  @useResult
  $Res call({int id, String name, String icon, String? query, String? description});
}

/// @nodoc
class _$GameCategoryCopyWithImpl<$Res, $Val extends GameCategory> implements $GameCategoryCopyWith<$Res> {
  _$GameCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameCategory
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
abstract class _$$GameCategoryImplCopyWith<$Res> implements $GameCategoryCopyWith<$Res> {
  factory _$$GameCategoryImplCopyWith(_$GameCategoryImpl value, $Res Function(_$GameCategoryImpl) then) =
      __$$GameCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String icon, String? query, String? description});
}

/// @nodoc
class __$$GameCategoryImplCopyWithImpl<$Res> extends _$GameCategoryCopyWithImpl<$Res, _$GameCategoryImpl>
    implements _$$GameCategoryImplCopyWith<$Res> {
  __$$GameCategoryImplCopyWithImpl(_$GameCategoryImpl _value, $Res Function(_$GameCategoryImpl) _then)
    : super(_value, _then);

  /// Create a copy of GameCategory
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
      _$GameCategoryImpl(
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

class _$GameCategoryImpl implements _GameCategory {
  const _$GameCategoryImpl({required this.id, required this.name, required this.icon, this.query, this.description});

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
    return 'GameCategory(id: $id, name: $name, icon: $icon, query: $query, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.description, description) || other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, query, description);

  /// Create a copy of GameCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameCategoryImplCopyWith<_$GameCategoryImpl> get copyWith =>
      __$$GameCategoryImplCopyWithImpl<_$GameCategoryImpl>(this, _$identity);
}

abstract class _GameCategory implements GameCategory {
  const factory _GameCategory({
    required final int id,
    required final String name,
    required final String icon,
    final String? query,
    final String? description,
  }) = _$GameCategoryImpl;

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

  /// Create a copy of GameCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameCategoryImplCopyWith<_$GameCategoryImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FilterShortcut {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get query => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  /// Create a copy of FilterShortcut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterShortcutCopyWith<FilterShortcut> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterShortcutCopyWith<$Res> {
  factory $FilterShortcutCopyWith(FilterShortcut value, $Res Function(FilterShortcut) then) =
      _$FilterShortcutCopyWithImpl<$Res, FilterShortcut>;
  @useResult
  $Res call({int id, String name, String icon, String type, String? query, String? value});
}

/// @nodoc
class _$FilterShortcutCopyWithImpl<$Res, $Val extends FilterShortcut> implements $FilterShortcutCopyWith<$Res> {
  _$FilterShortcutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterShortcut
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
abstract class _$$FilterShortcutImplCopyWith<$Res> implements $FilterShortcutCopyWith<$Res> {
  factory _$$FilterShortcutImplCopyWith(_$FilterShortcutImpl value, $Res Function(_$FilterShortcutImpl) then) =
      __$$FilterShortcutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String icon, String type, String? query, String? value});
}

/// @nodoc
class __$$FilterShortcutImplCopyWithImpl<$Res> extends _$FilterShortcutCopyWithImpl<$Res, _$FilterShortcutImpl>
    implements _$$FilterShortcutImplCopyWith<$Res> {
  __$$FilterShortcutImplCopyWithImpl(_$FilterShortcutImpl _value, $Res Function(_$FilterShortcutImpl) _then)
    : super(_value, _then);

  /// Create a copy of FilterShortcut
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
      _$FilterShortcutImpl(
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

class _$FilterShortcutImpl implements _FilterShortcut {
  const _$FilterShortcutImpl({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    this.query,
    this.value,
  });

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
    return 'FilterShortcut(id: $id, name: $name, icon: $icon, type: $type, query: $query, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterShortcutImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, type, query, value);

  /// Create a copy of FilterShortcut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterShortcutImplCopyWith<_$FilterShortcutImpl> get copyWith =>
      __$$FilterShortcutImplCopyWithImpl<_$FilterShortcutImpl>(this, _$identity);
}

abstract class _FilterShortcut implements FilterShortcut {
  const factory _FilterShortcut({
    required final int id,
    required final String name,
    required final String icon,
    required final String type,
    final String? query,
    final String? value,
  }) = _$FilterShortcutImpl;

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

  /// Create a copy of FilterShortcut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterShortcutImplCopyWith<_$FilterShortcutImpl> get copyWith => throw _privateConstructorUsedError;
}
