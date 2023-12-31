import 'package:flutter/material.dart';

class AppNavigationKey {
  const AppNavigationKey._();

  /// Returns the [NavigatorState] value to be set in the applications navigation
  static final GlobalKey<NavigatorState> _appNavigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get() {
    return _appNavigatorKey;
  }
}

mixin AppNavigationMixin {
  /// Replace the current route of the navigator by pushing the route named
  /// [route] and then disposing the previous route once the new route has
  /// finished animating in.
  Future<T?>? removeCurrentAndGoNamed<T>({
    required String route,
    Object? arguments,
  }) {
    return AppNavigationKey.get()
        .currentState
        ?.pushReplacementNamed(route, arguments: arguments);
  }

  /// Pop the top-most route off the navigator.
  bool back<T>({
    T? result,
  }) {
    AppNavigationKey.get().currentState?.pop<T>(result);
    return AppNavigationKey.get().currentState?.canPop() ?? false;
  }

  /// Push a named route onto the navigator.
  Future<T?>? goNamed<T>({
    Object? arguments,
    required String route,
  }) {
    return AppNavigationKey.get()
        .currentState
        ?.pushNamed<T>(route, arguments: arguments);
  }

  /// Push the route with the given name onto the navigator, and then remove all
  /// the previous routes until the `predicate` returns true.
  Future<T?>? removeUntilAndGoNamed<T>({
    Object? arguments,
    required String route,
  }) {
    return AppNavigationKey.get().currentState?.pushNamedAndRemoveUntil<T>(
        route, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}
