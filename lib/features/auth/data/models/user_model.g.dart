// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) => _$UserModelImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  location: json['location'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  responseTime: json['response_time'] as String?,
  memberSince: json['member_since'] == null ? null : DateTime.parse(json['member_since'] as String),
  completedRentals: (json['completed_rentals'] as num?)?.toInt() ?? 0,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  totalReviews: (json['total_reviews'] as num?)?.toInt() ?? 0,
  isActive: json['is_active'] as bool? ?? true,
  createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'location': instance.location,
  'avatar_url': instance.avatarUrl,
  'response_time': instance.responseTime,
  'member_since': instance.memberSince?.toIso8601String(),
  'completed_rentals': instance.completedRentals,
  'rating': instance.rating,
  'total_reviews': instance.totalReviews,
  'is_active': instance.isActive,
  'created_at': instance.createdAt?.toIso8601String(),
};
