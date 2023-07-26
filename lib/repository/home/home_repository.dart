import 'package:flutter_social_media/app/app_exception.dart';
import 'package:flutter_social_media/app/app_state.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/entity/pagination_entity.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:flutter_social_media/repository/home/home_request.dart';
import 'package:flutter_social_media/service/http/http_client_service.dart';
import 'package:flutter_social_media/service/restful/request_interface.dart';
import 'package:flutter_social_media/service/restful/restful_service_impl.dart';

/// Home Repository using the http client. Calls API methods and parses responses.
class HomeRepository {
  HomeRepository({HttpClientService? client})
      : client = client ?? HttpClientService(interface: RestfulServiceImpl());
  final HttpClientService client;

  Future<BaseEntity<PaginationEntity<UserEntity>>> getListUser() async {
    final response = await _getData<PaginationEntity<UserEntity>>(
      request: GetListUserRequest(),
    );
    return BaseEntity<PaginationEntity<UserEntity>>(
      data: response.data,
      state: AppState.ok,
    );
  }

  Future<BaseEntity<T>> _getData<T>({required RequestInterface request}) async {
    try {
      final response = await client.send(request);
      return BaseEntity<T>(data: response, state: AppState.ok);
    } on ResourceNotFoundException catch (e) {
      return BaseEntity<T>(state: AppState.fromString(e.error));
    } on AppIdNotExistException catch (e) {
      return BaseEntity<T>(state: AppState.fromString(e.error));
    } on AppIdMissingException catch (e) {
      return BaseEntity<T>(state: AppState.fromString(e.error));
    } on ParamsNotValidException catch (e) {
      return BaseEntity<T>(state: AppState.fromString(e.error));
    } on BodyNotValidException catch (e) {
      return BaseEntity<T>(state: AppState.fromString(e.error));
    } on PathNotFoundException catch (e) {
      return BaseEntity<T>(state: AppState.fromString(e.error));
    } on ServerErrorException catch (e) {
      return BaseEntity<T>(state: AppState.fromString(e.error));
    } catch (error) {
      return BaseEntity<T>(state: AppState.fromString(error.toString()));
    }
  }
}
