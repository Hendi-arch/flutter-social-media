import 'package:flutter_social_media/entity/converter/datetime_attribute_converter.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_entity.g.dart';

@JsonSerializable()
@DateTimeAttributeConverter()
class PostEntity {
  String id;
  String text;
  String image;
  int likes;
  String link;
  List<String> tags;
  DateTime publishDate;
  UserEntity owner;

  PostEntity({
    required this.id,
    required this.text,
    required this.image,
    required this.likes,
    required this.link,
    required this.tags,
    required this.publishDate,
    required this.owner,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostEntityToJson(this);
}
