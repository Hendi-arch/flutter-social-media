import 'package:flutter_social_media/app/app_state.dart';

extension BaseEntityViewBuilderExtension<T> on BaseEntity<T> {
  R when<R>({
    required R Function(T data) data,
    required R Function(Object error) error,
    required R Function() loading,
  }) {
    if (state == AppState.loading) {
      return loading();
    }

    if (state != AppState.ok &&
        state != AppState.loading &&
        this.data != null) {
      return error(state.value);
    }

    return data(this.data as T);
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
