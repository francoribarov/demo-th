// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListingImageModelImpl _$$ListingImageModelImplFromJson(Map<String, dynamic> json) => _$ListingImageModelImpl(
  url: json['url'] as String,
  type: json['type'] as String,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$$ListingImageModelImplToJson(_$ListingImageModelImpl instance) => <String, dynamic>{
  'url': instance.url,
  'type': instance.type,
  'width': instance.width,
  'height': instance.height,
};

_$ListingModelImpl _$$ListingModelImplFromJson(Map<String, dynamic> json) => _$ListingModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  publisher: json['publisher'] as String?,
  category: json['category'] as String,
  description: json['description'] as String,
  rating: (json['rating'] as num?)?.toDouble(),
  reviews: (json['reviews'] as num?)?.toInt(),
  duration: json['duration'] as String?,
  players: json['players'] as String?,
  difficulty: json['difficulty'] as String?,
  pricePerDay: (json['pricePerDay'] as num).toInt(),
  deposit: (json['deposit'] as num?)?.toInt(),
  condition: json['condition'] as String,
  visibility: json['visibility'] as String,
  ownerId: json['ownerId'] as String,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => ListingImageModel.fromJson(e as Map<String, dynamic>)).toList() ??
      const [],
);

Map<String, dynamic> _$$ListingModelImplToJson(_$ListingModelImpl instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'publisher': instance.publisher,
  'category': instance.category,
  'description': instance.description,
  'rating': instance.rating,
  'reviews': instance.reviews,
  'duration': instance.duration,
  'players': instance.players,
  'difficulty': instance.difficulty,
  'pricePerDay': instance.pricePerDay,
  'deposit': instance.deposit,
  'condition': instance.condition,
  'visibility': instance.visibility,
  'ownerId': instance.ownerId,
  'images': instance.images,
};

_$ListingCreateRequestModelImpl _$$ListingCreateRequestModelImplFromJson(Map<String, dynamic> json) =>
    _$ListingCreateRequestModelImpl(
      title: json['title'] as String,
      publisher: json['publisher'] as String?,
      category: json['category'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String?,
      players: json['players'] as String?,
      difficulty: json['difficulty'] as String?,
      pricePerDay: (json['pricePerDay'] as num).toInt(),
      deposit: (json['deposit'] as num?)?.toInt(),
      condition: json['condition'] as String,
      visibility: json['visibility'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => ListingImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ListingCreateRequestModelImplToJson(_$ListingCreateRequestModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'publisher': instance.publisher,
      'category': instance.category,
      'description': instance.description,
      'duration': instance.duration,
      'players': instance.players,
      'difficulty': instance.difficulty,
      'pricePerDay': instance.pricePerDay,
      'deposit': instance.deposit,
      'condition': instance.condition,
      'visibility': instance.visibility,
      'images': instance.images,
    };
