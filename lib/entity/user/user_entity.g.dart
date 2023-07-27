// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      dateOfBirth: const DateTimeAttributeConverter()
          .fromJson(json['dateOfBirth'] as String?),
      registerDate: const DateTimeAttributeConverter()
          .fromJson(json['registerDate'] as String?),
      phone: json['phone'] as String?,
      picture: json['picture'] as String,
      userLocation: json['location'] == null
          ? null
          : UserLocationEntity.fromJson(
              json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'email': instance.email,
      'dateOfBirth':
          const DateTimeAttributeConverter().toJson(instance.dateOfBirth),
      'registerDate':
          const DateTimeAttributeConverter().toJson(instance.registerDate),
      'phone': instance.phone,
      'picture': instance.picture,
      'location': instance.userLocation,
    };
