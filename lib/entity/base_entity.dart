import 'package:flutter_social_media/app/app_state.dart';

extension BaseEntityExtension<T> on BaseEntity<T> {
  R when<R>({
    bool skipLoadingOnRefresh = true,
    required R Function(T data) data,
    required R Function(BaseEntity<T> error) error,
    R Function()? loading,
  }) {
    if (state == AppState.loading) {
      bool skip;
      if (this.data != null) {
        skip = skipLoadingOnRefresh;
      } else {
        skip = false;
      }
      if (!skip) return loading!();
    }

    if (state != AppState.ok && state != AppState.loading) {
      return error(this);
    }

    return data(this.data as T);
  }

  void setStateLoading() {
    state = AppState.loading;
  }
}

class BaseEntity<T> {
  AppState state;
  String stateDescription;
  T? data;

  BaseEntity({
    required this.state,
    required this.stateDescription,
    this.data,
  });

  BaseEntity.ok({
    this.data,
  })  : state = AppState.ok,
        stateDescription = 'OK';

  BaseEntity.loading()
      : state = AppState.loading,
        stateDescription = 'LOADING';

  BaseEntity.resourceNotFound({required this.stateDescription})
      : state = AppState.resourceNotFound;

  BaseEntity.appIdNotExist({required this.stateDescription})
      : state = AppState.appIdNotExist;

  BaseEntity.appIdMissing({required this.stateDescription})
      : state = AppState.appIdMissing;

  BaseEntity.paramsNotValid({required this.stateDescription})
      : state = AppState.paramsNotValid;

  BaseEntity.bodyNotValid({required this.stateDescription})
      : state = AppState.bodyNotValid;

  BaseEntity.pathNotFound({required this.stateDescription})
      : state = AppState.pathNotFound;

  BaseEntity.serverError({required this.stateDescription})
      : state = AppState.serverError;

  BaseEntity.unknown({required this.stateDescription})
      : state = AppState.unknown;
}
