import 'package:flutter_social_media/service/restful/request_interface.dart';
import 'package:flutter_social_media/service/restful/restful_interface.dart';

class RestfulService {
  late RestfulInterface _restfulInterface;

  RestfulService({
    required RestfulInterface interface,
  }) {
    _restfulInterface = interface;
  }

  Future<T> send<T>(RequestInterface request) async {
    final url = request.url;

    dynamic json;

    switch (request.method) {
      case RestfulMethod.get:
        json = await _restfulInterface.get(
          uri: url,
          options: request.options,
          cancelToken: request.cancelToken,
          onReceiveProgress: request.onReceiveProgress,
          queryParameters: _convertQueryParams(request.queryParameters),
        );
        break;
      case RestfulMethod.post:
        json = await _restfulInterface.post(
          uri: url,
          options: request.options,
          cancelToken: request.cancelToken,
          data: _convertBodyParams(request.body),
          onSendProgress: request.onSendProgress,
          onReceiveProgress: request.onReceiveProgress,
          queryParameters: _convertQueryParams(request.queryParameters),
        );
        break;
    }

    final res = await request.response(json);
    return res as T;
  }

  dynamic _convertBodyParams(dynamic body) {
    if (body == null) {
      return {};
    } else {
      return body;
    }
  }

  Map<String, dynamic> _convertQueryParams(Map<String, dynamic>? q) {
    if (q == null) return {};
    final result = <String, dynamic>{};
    q.forEach((key, value) {
      if (value is List) {
        if (value is List<String>) {
          result[key] = value;
        } else {
          result[key] = value.map((e) => e.toString()).toList();
        }
      } else if (value != null) {
        result[key] = value.toString();
      }
    });
    return result;
  }
}
