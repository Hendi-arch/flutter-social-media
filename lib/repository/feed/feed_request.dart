import 'package:flutter_social_media/app/app_endpoint.dart';
import 'package:flutter_social_media/entity/pagination_entity.dart';
import 'package:flutter_social_media/entity/post/post_entity.dart';
import 'package:flutter_social_media/service/restful/request_interface.dart';

class GetListFeedRequest extends RequestInterface {
  @override
  RestfulMethod get method => RestfulMethod.get;

  GetListFeedRequest({int page = 0, int limit = 20}) : super() {
    url = AppEndpoint.getPostList;
    queryParameters["page"] = page;
    queryParameters["limit"] = limit;
  }

  @override
  Future<PaginationEntity<PostEntity>> response(res) async =>
      PaginationEntity.fromJson(res);
}
