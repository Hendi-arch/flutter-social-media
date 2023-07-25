class AppEndpoint {
  const AppEndpoint._();

  /// Base URL
  static const String baseUrl = 'https://dummyapi.io/data/v1/';

  /// Endpoints
  static const String getListUser = 'user/';
  static const String getUserById = 'user/:id';
  static const String getPostListByUser = 'user/:id/post';
  static const String getPostList = 'post';
  static const String getListByTag = 'tag/:id/post';
}
