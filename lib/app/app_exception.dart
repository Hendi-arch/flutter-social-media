/// Applicable for all requests that has {id} URL param.
/// Mean that item that was requested(for get, update, delete) is not found.
/// Works correctly if you try to create a post for user that not exist or deleted.
class ResourceNotFoundException implements Exception {
  final String error;

  ResourceNotFoundException(this.error);

  @override
  String toString() => "RESOURCE_NOT_FOUND";
}

/// app-id header is found but the value is not valid.
class AppIdNotExistException implements Exception {
  final String error;

  AppIdNotExistException(this.error);

  @override
  String toString() => "APP_ID_NOT_EXIST";
}

/// app-id header is not set correctly.
/// Note that you need to set app-id header for each request.
/// [Getting Started](https://dummyapi.io/docs) page for more info.
class AppIdMissingException implements Exception {
  final String error;

  AppIdMissingException(this.error);

  @override
  String toString() => "APP_ID_MISSING";
}

/// URL params (ex: /user/{id} - {id} is URL param) is not valid.
/// This error returned in both cases: param format is invalid, param is not found.
class ParamsNotValidException implements Exception {
  final String error;

  ParamsNotValidException(this.error);

  @override
  String toString() => "PARAMS_NOT_VALID";
}

/// Applicable only for not GET requests like POST, PUT or DELETE.
/// Boyd format is invalid, or even some keys are not valid.
class BodyNotValidException implements Exception {
  final String error;

  BodyNotValidException(this.error);

  @override
  String toString() => "BODY_NOT_VALID";
}

/// Request path is not valid, check controller documentation to validate the URL.
class PathNotFoundException implements Exception {
  final String error;

  PathNotFoundException(this.error);

  @override
  String toString() => "PATH_NOT_FOUND";
}

/// Something is wrong with server, try again later. And/or report to our support telegram channel/email.
class ServerErrorException implements Exception {
  final String error;

  ServerErrorException(this.error);

  @override
  String toString() => "SERVER_ERROR";
}
