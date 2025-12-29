// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(email: json['email'] as String, password: json['password'] as String);

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
};

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(Map<String, dynamic> json) => _$RegisterRequestImpl(
  email: json['email'] as String,
  password: json['password'] as String,
  name: json['name'] as String,
  location: json['location'] as String?,
);

Map<String, dynamic> _$$RegisterRequestImplToJson(_$RegisterRequestImpl instance) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'name': instance.name,
  'location': instance.location,
};

_$TokenResponseImpl _$$TokenResponseImplFromJson(Map<String, dynamic> json) => _$TokenResponseImpl(
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
  tokenType: json['token_type'] as String? ?? 'bearer',
);

Map<String, dynamic> _$$TokenResponseImplToJson(_$TokenResponseImpl instance) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'token_type': instance.tokenType,
};

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) => _$AuthResponseImpl(
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
  tokenType: json['token_type'] as String? ?? 'bearer',
);

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) => <String, dynamic>{
  'user': instance.user,
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'token_type': instance.tokenType,
};

_$RefreshTokenRequestImpl _$$RefreshTokenRequestImplFromJson(Map<String, dynamic> json) =>
    _$RefreshTokenRequestImpl(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$$RefreshTokenRequestImplToJson(_$RefreshTokenRequestImpl instance) => <String, dynamic>{
  'refreshToken': instance.refreshToken,
};
