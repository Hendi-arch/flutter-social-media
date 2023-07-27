import 'package:flutter_social_media/app/app_exception.dart';
import 'package:flutter_social_media/app/app_state.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/entity/pagination_entity.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:flutter_social_media/repository/home/home_request.dart';
import 'package:flutter_social_media/service/http/http_client_service.dart';
import 'package:flutter_social_media/service/restful/request_interface.dart';
import 'package:flutter_social_media/service/restful/restful_service_impl.dart';
import 'package:loggy/loggy.dart';

/// Home Repository using the http client. Calls API methods and parses responses.
class HomeRepository with NetworkLoggy {
  HomeRepository({HttpClientService? client})
      : client = client ?? HttpClientService(interface: RestfulServiceImpl());
  final HttpClientService client;

  Future<BaseEntity<PaginationEntity<UserEntity>>> getListUser(
      {int page = 0, int limit = 20}) async {
    final response = await _getData<PaginationEntity<UserEntity>>(
      request: GetListUserRequest(page: page, limit: limit),
    );
    return BaseEntity<PaginationEntity<UserEntity>>(
      data: response.data,
      state: response.state,
    );
  }

  Future<BaseEntity<T>> _getData<T>({required RequestInterface request}) async {
    try {
      final response = await client.send<T>(request);
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
    } catch (error, trace) {
      loggy.error('${AppState.unknown.value} - $error', error, trace);
      return BaseEntity<T>(state: AppState.fromString(error.toString()));
    }
  }
}
