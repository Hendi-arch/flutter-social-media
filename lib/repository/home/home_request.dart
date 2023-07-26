import 'package:flutter_social_media/app/app_endpoint.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:flutter_social_media/service/restful/request_interface.dart';

class GetListUserRequest extends RequestInterface {
  @override
  RestfulMethod get method => RestfulMethod.get;

  GetListUserRequest({int page = 0, int limit = 20}) : super() {
    url = AppEndpoint.getListUser;
  }

  @override
  Future<BaseEntity<UserEntity>> response(res) async =>
      BaseEntity.fromJson(res);
}
