import 'package:dio/dio.dart';
import 'package:flutter_social_media/app/app_exception.dart';
import 'package:flutter_social_media/app/app_state.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/entity/pagination_entity.dart';
import 'package:flutter_social_media/entity/post/post_entity.dart';
import 'package:flutter_social_media/repository/feed/feed_request.dart';
import 'package:flutter_social_media/service/http/http_client_service.dart';
import 'package:flutter_social_media/service/restful/request_interface.dart';
import 'package:flutter_social_media/service/restful/restful_service_impl.dart';
import 'package:loggy/loggy.dart';

/// Feed Repository using the http client. Calls API methods and parses responses.
class FeedRepository with NetworkLoggy {
  FeedRepository({HttpClientService? client})
      : client = client ?? HttpClientService(interface: RestfulServiceImpl());
  final HttpClientService client;

  Future<BaseEntity<PaginationEntity<PostEntity>>> getListFeed(
      {int page = 0, int limit = 20}) async {
    final response = await _getData<PaginationEntity<PostEntity>>(
      request: GetListFeedRequest(page: page, limit: limit),
    );

    response.data ??= PaginationEntity<PostEntity>.empty();
    response.data!.listData ??= [];
    response.data!.isLastPage = response.data!.listData!.isEmpty;
    return BaseEntity<PaginationEntity<PostEntity>>(
      data: response.data,
      state: response.state,
      stateDescription: response.stateDescription,
    );
  }

  Future<BaseEntity<T>> _getData<T>({required RequestInterface request}) async {
    try {
      final response = await client.send<T>(request);
      return BaseEntity<T>.ok(data: response);
    } on ResourceNotFoundException catch (e) {
      return BaseEntity.resourceNotFound(stateDescription: e.toString());
    } on AppIdNotExistException catch (e) {
      return BaseEntity.appIdNotExist(stateDescription: e.toString());
    } on AppIdMissingException catch (e) {
      return BaseEntity.appIdMissing(stateDescription: e.toString());
    } on ParamsNotValidException catch (e) {
      return BaseEntity.paramsNotValid(stateDescription: e.toString());
    } on BodyNotValidException catch (e) {
      return BaseEntity.bodyNotValid(stateDescription: e.toString());
    } on PathNotFoundException catch (e) {
      return BaseEntity.pathNotFound(stateDescription: e.toString());
    } on ServerErrorException catch (e) {
      return BaseEntity.serverError(stateDescription: e.toString());
    } on DioException catch (e) {
      loggy.error(e.message, e.error, e.stackTrace);
      return BaseEntity.unknown(
        stateDescription: '${e.type.name.toUpperCase()} - ${e.error ?? ''}',
      );
    } catch (error, trace) {
      loggy.error('${AppState.unknown.value} - $error', error, trace);
      return BaseEntity.unknown(
        stateDescription: '${AppState.unknown.value} - $error',
      );
    }
  }
}
