import 'package:flutter_social_media/app/app_exception.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/repository/home/home_request.dart';
import 'package:flutter_social_media/service/http/http_client_service.dart';
import 'package:flutter_social_media/service/restful/request_interface.dart';
import 'package:flutter_social_media/service/restful/restful_service_impl.dart';

/// Home Repository using the http client. Calls API methods and parses responses.
class HomeRepository {
  HomeRepository({HttpClientService? client})
      : client = client ?? HttpClientService(interface: RestfulServiceImpl());
  final HttpClientService client;

  Future<BaseEntity> getListUser() => _getData(
        request: GetListUserRequest(),
        builder: (data) => data,
      );

  Future<T> _getData<T>({
    required RequestInterface request,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.send<T>(request);
      return response;
    } on ResourceNotFoundException catch (e) {
      throw ResourceNotFoundException(e.toString());
    } on AppIdNotExistException catch (e) {
      throw AppIdNotExistException(e.toString());
    } on AppIdMissingException catch (e) {
      throw AppIdMissingException(e.toString());
    } on ParamsNotValidException catch (e) {
      throw ParamsNotValidException(e.toString());
    } on BodyNotValidException catch (e) {
      throw BodyNotValidException(e.toString());
    } on PathNotFoundException catch (e) {
      throw PathNotFoundException(e.toString());
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e.toString());
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
