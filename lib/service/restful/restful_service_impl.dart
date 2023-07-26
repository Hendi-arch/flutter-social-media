import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:flutter_social_media/app/app_endpoint.dart';
import 'package:flutter_social_media/app/app_secret.dart';
import 'package:flutter_social_media/service/http/http_client_interface.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class RestfulServiceImpl extends HttpClientInterface {
  final Dio _dio = Dio();
  final List<Interceptor> interceptors = [];

  RestfulServiceImpl() {
    _dio
      ..options.baseUrl = AppEndpoint.baseUrl
      ..options.connectTimeout =
          const Duration(milliseconds: _defaultConnectTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: _defaultReceiveTimeout)
      ..options.headers = {'app-id': AppSecret.appId};

    if (!kReleaseMode) {
      _dio.interceptors.add(LoggyDioInterceptor(
        error: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ));
    }
  }

  @override
  Future get({
    required String uri,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response = await _dio.get(
      uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }

  @override
  Future post({
    required String uri,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response = await _dio.post(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }
}
