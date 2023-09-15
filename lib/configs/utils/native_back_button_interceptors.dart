// coverage:ignore-file

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/router/app_navigator.dart';

/// Contains interceptors that manage how the native android/ios back button is
/// handled.
abstract final class NativeBackButtonInterceptors {
  /// Call [AppNavigator.movies] instead [Navigator.pop].
  static InterceptorFunction toMovies(BuildContext context) {
    return (bool stopDefaultButtonEvent, RouteInfo info) {
      Future.microtask(() => AppNavigator.movies(context));

      return true;
    };
  }
}
