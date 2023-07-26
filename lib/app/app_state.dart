class AppState {
  /// Constructs an instance of [AppState].
  const AppState(this.value);

  static const AppState ok = AppState('OK');

  static const AppState loading = AppState('LOADING');

  static const AppState resourceNotFound = AppState('RESOURCE_NOT_FOUND');

  static const AppState appIdNotExist = AppState('APP_ID_NOT_EXIST');

  static const AppState appIdMissing = AppState('APP_ID_MISSING');

  static const AppState paramsNotValid = AppState('PARAMS_NOT_VALID');

  static const AppState bodyNotValid = AppState('BODY_NOT_VALID');

  static const AppState pathNotFound = AppState('PATH_NOT_FOUND');

  static const AppState serverError = AppState('SERVER_ERROR');

  static const AppState unknown = AppState('UNKNOWN');

  /// All the possible values for the [AppState] enumeration.
  static List<AppState> get values => [
        ok,
        loading,
        resourceNotFound,
        appIdNotExist,
        appIdMissing,
        paramsNotValid,
        bodyNotValid,
        pathNotFound,
        serverError,
        unknown,
      ];

  /// Get [AppState] from [String].
  static AppState fromString(String? value) {
    return values.firstWhere((category) => category.value == value,
        orElse: () => unknown);
  }

  /// The string representation.
  final String value;
}
