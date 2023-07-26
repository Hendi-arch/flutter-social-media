import 'package:dio/dio.dart';

enum RestfulMethod { get, post }

abstract class RequestInterface {
  String url = '';
  RestfulMethod get method;

  dynamic body;
  Options? options;
  CancelToken? cancelToken;
  ProgressCallback? onSendProgress;
  ProgressCallback? onReceiveProgress;
  Map<String, dynamic> queryParameters = {};

  RequestInterface();

  Future response(dynamic res) async {}
}
