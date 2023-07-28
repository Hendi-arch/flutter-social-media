import 'package:flutter_social_media/entity/post/post_entity.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_entity.g.dart';

@JsonSerializable(createToJson: false)
class PaginationEntity<T> {
  int total;
  int page;
  int limit;

  @JsonKey(fromJson: _dataFromJson, name: 'data')
  List<T>? listData;

  PaginationEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.listData,
  });

  PaginationEntity.empty()
      : total = 0,
        page = 0,
        limit = 20,
        listData = [];

  factory PaginationEntity.fromJson(Map<String, dynamic> json) =>
      _$PaginationEntityFromJson(json);

  /// Decodes [json] by "inspecting" its contents.
  static T? _dataFromJson<T>(Object json) {
    if (json is List) {
      if (json.isEmpty) {
        return null;
      }

      if (json.any((element) =>
          element is Map<String, dynamic> &&
          element.containsKey('firstName'))) {
        return json
            .map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
            .toList() as T;
      } else if (json.any((element) =>
          element is Map<String, dynamic> && element.containsKey('text'))) {
        return json
            .map((e) => PostEntity.fromJson(e as Map<String, dynamic>))
            .toList() as T;
      }
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }
}
