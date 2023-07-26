import 'package:flutter_social_media/app/app_exception.dart';
import 'package:flutter_social_media/entity/post/post_entity.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_entity.g.dart';

@JsonSerializable(createToJson: false)
class BaseEntity<T> {
  final int total;
  final int page;
  final int limit;

  @JsonKey(fromJson: _dataFromJson)
  final List<T> data;

  const BaseEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.data,
  });

  factory BaseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseEntityFromJson(json);

  /// Decodes [json] by "inspecting" its contents.
  static T _dataFromJson<T>(Object json) {
    if (json is Map<String, dynamic> && json.containsKey('error')) {
      throw AppException(json['error']);
    }

    if (T is UserEntity) {
      return (json as List<Map<String, dynamic>>)
          .map((e) => UserEntity.fromJson(e))
          .toList() as T;
    } else if (T is PostEntity) {
      return (json as List<Map<String, dynamic>>)
          .map((e) => PostEntity.fromJson(e))
          .toList() as T;
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }
}
