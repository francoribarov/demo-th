// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AvailabilityRangeModelImpl _$$AvailabilityRangeModelImplFromJson(Map<String, dynamic> json) =>
    _$AvailabilityRangeModelImpl(from: json['from'] as String, to: json['to'] as String);

Map<String, dynamic> _$$AvailabilityRangeModelImplToJson(_$AvailabilityRangeModelImpl instance) => <String, dynamic>{
  'from': instance.from,
  'to': instance.to,
};

_$GameRulesModelImpl _$$GameRulesModelImplFromJson(Map<String, dynamic> json) =>
    _$GameRulesModelImpl(video: json['video'] as String, text: json['text'] as String);

Map<String, dynamic> _$$GameRulesModelImplToJson(_$GameRulesModelImpl instance) => <String, dynamic>{
  'video': instance.video,
  'text': instance.text,
};

_$GameReviewModelImpl _$$GameReviewModelImplFromJson(Map<String, dynamic> json) => _$GameReviewModelImpl(
  name: json['name'] as String,
  role: json['role'] as String,
  rating: (json['rating'] as num).toDouble(),
  comment: json['comment'] as String,
);

Map<String, dynamic> _$$GameReviewModelImplToJson(_$GameReviewModelImpl instance) => <String, dynamic>{
  'name': instance.name,
  'role': instance.role,
  'rating': instance.rating,
  'comment': instance.comment,
};

_$GameModelImpl _$$GameModelImplFromJson(Map<String, dynamic> json) => _$GameModelImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  category: json['category'] as String,
  image: json['image'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviews: (json['reviews'] as num).toInt(),
  description: json['description'] as String,
  duration: json['duration'] as String,
  players: json['players'] as String,
  difficulty: json['difficulty'] as String,
  price: (json['price'] as num).toInt(),
  availability: (json['availability'] as List<dynamic>?)
      ?.map((e) => AvailabilityRangeModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  rules: json['rules'] == null ? null : GameRulesModel.fromJson(json['rules'] as Map<String, dynamic>),
  reviewsList:
      (json['reviews_list'] as List<dynamic>?)
          ?.map((e) => GameReviewModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$GameModelImplToJson(_$GameModelImpl instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'category': instance.category,
  'image': instance.image,
  'rating': instance.rating,
  'reviews': instance.reviews,
  'description': instance.description,
  'duration': instance.duration,
  'players': instance.players,
  'difficulty': instance.difficulty,
  'price': instance.price,
  'availability': instance.availability,
  'rules': instance.rules,
  'reviews_list': instance.reviewsList,
};

_$GameCategoryModelImpl _$$GameCategoryModelImplFromJson(Map<String, dynamic> json) => _$GameCategoryModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  icon: json['icon'] as String,
  query: json['query'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$GameCategoryModelImplToJson(_$GameCategoryModelImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
  'query': instance.query,
  'description': instance.description,
};

_$FilterShortcutModelImpl _$$FilterShortcutModelImplFromJson(Map<String, dynamic> json) => _$FilterShortcutModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  icon: json['icon'] as String,
  type: json['type'] as String,
  query: json['query'] as String?,
  value: json['value'] as String?,
);

Map<String, dynamic> _$$FilterShortcutModelImplToJson(_$FilterShortcutModelImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
  'type': instance.type,
  'query': instance.query,
  'value': instance.value,
};
