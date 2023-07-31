import 'package:flutter_social_media/app/app_endpoint.dart';
import 'package:flutter_social_media/entity/pagination_entity.dart';
import 'package:flutter_social_media/entity/post/post_entity.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:flutter_social_media/service/restful/request_interface.dart';

class GetProfileRequest extends RequestInterface {
  @override
  RestfulMethod get method => RestfulMethod.get;

  GetProfileRequest({required String userId}) : super() {
    url = AppEndpoint.getUserById.replaceFirst(':id', userId);
  }

  @override
  Future<UserEntity> response(res) async => UserEntity.fromJson(res);
}

class GetProfileListFeedRequest extends RequestInterface {
  @override
  RestfulMethod get method => RestfulMethod.get;

  GetProfileListFeedRequest({
    int page = 0,
    int limit = 20,
    required String userId,
  }) : super() {
    url = AppEndpoint.getPostListByUser.replaceFirst(':id', userId);
    queryParameters["page"] = page;
    queryParameters["limit"] = limit;
  }

  @override
  Future<PaginationEntity<PostEntity>> response(res) async =>
      PaginationEntity.fromJson(res);
}
