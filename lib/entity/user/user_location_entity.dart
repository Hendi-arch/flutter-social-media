import 'package:json_annotation/json_annotation.dart';

part 'user_location_entity.g.dart';

@JsonSerializable()
class UserLocationEntity {
  String street;
  String city;
  String state;
  String country;
  String timezone;

  UserLocationEntity({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.timezone,
  });

  factory UserLocationEntity.fromJson(Map<String, dynamic> json) =>
      _$UserLocationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationEntityToJson(this);
}
