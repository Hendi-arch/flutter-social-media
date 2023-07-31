import 'package:flutter_social_media/entity/converter/datetime_attribute_converter.dart';
import 'package:flutter_social_media/entity/user/user_location_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
@DateTimeAttributeConverter()
class UserEntity {
  String id;
  String title;
  String firstName;
  String lastName;
  String? gender;
  String? email;
  DateTime? dateOfBirth;
  DateTime? registerDate;
  String? phone;
  String picture;

  @JsonKey(name: 'location')
  UserLocationEntity? userLocation;

  UserEntity({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.dateOfBirth,
    required this.registerDate,
    required this.phone,
    required this.picture,
    required this.userLocation,
  });

  UserEntity.empty()
      : id = '',
        title = '',
        firstName = '',
        lastName = '',
        picture = '';

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
