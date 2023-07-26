// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocationEntity _$UserLocationEntityFromJson(Map<String, dynamic> json) =>
    UserLocationEntity(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$UserLocationEntityToJson(UserLocationEntity instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'timezone': instance.timezone,
    };
