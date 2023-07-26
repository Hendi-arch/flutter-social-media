import 'package:flutter_social_media/app/app_exception.dart';
import 'package:flutter_social_media/entity/post/post_entity.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_entity.g.dart';

@JsonSerializable(createToJson: false)
class PaginationEntity<T> {
  int total;
  int page;
  int limit;

  @JsonKey(fromJson: _dataFromJson)
  List<T> data;

  PaginationEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.data,
  });

  factory PaginationEntity.fromJson(Map<String, dynamic> json) =>
      _$PaginationEntityFromJson(json);

  /// Decodes [json] by "inspecting" its contents.
  static T _dataFromJson<T>(Object json) {
    if (json is Map<String, dynamic> && json.containsKey('error')) {
      String error = json['error'];
      switch (error) {
        case 'RESOURCE_NOT_FOUND':
          throw ResourceNotFoundException(error);
        case 'APP_ID_NOT_EXIST':
          throw AppIdNotExistException(error);
        case 'APP_ID_MISSING':
          throw AppIdMissingException(error);
        case 'PARAMS_NOT_VALID':
          throw ParamsNotValidException(error);
        case 'BODY_NOT_VALID':
          throw BodyNotValidException(error);
        case 'PATH_NOT_FOUND':
          throw PathNotFoundException(error);
        case 'SERVER_ERROR':
          throw ServerErrorException(error);
        default:
          throw Exception(error);
      }
    }

    if (json is List<Map<String, dynamic>>) {
      return json
          .map((e) => e.containsKey('email')
              ? UserEntity.fromJson(e)
              : PostEntity.fromJson(e))
          .toList() as T;
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }
}
