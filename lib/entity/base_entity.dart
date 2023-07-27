import 'package:flutter_social_media/app/app_state.dart';

extension BaseEntityExtension<T> on BaseEntity<T> {
  R when<R>({
    bool skipLoadingOnRefresh = true,
    required R Function(T data) data,
    required R Function(Object error) error,
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

    if (state != AppState.ok &&
        state != AppState.loading &&
        this.data != null) {
      return error(state.value);
    }

    return data(this.data as T);
  }

  void setStateLoading() {
    state = AppState.loading;
  }
}

class BaseEntity<T> {
  AppState state;
  T? data;

  BaseEntity({
    required this.state,
    this.data,
  });
}
