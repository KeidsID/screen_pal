// coverage:igore-file

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/interfaces/widgets/errors/app_error_widget.dart';
import 'package:screen_pal/interfaces/widgets/errors/app_http_error_widget.dart';

/// A widget to display brief info about the [DioException] that  provided.
class DioExceptionWidget extends StatelessWidget {
  /// Create a widget to display brief info about the [DioException] that
  /// provided.
  ///
  /// See also:
  ///
  ///  * [AppHttpErrorWidget], a widget to display brief info about the HTTP
  ///    error that occurred.
  const DioExceptionWidget(this.exception, {super.key, this.action});

  final DioException exception;

  /// Add widget on the bottom. Typically an [ElevatedButton].
  ///
  /// If null, then no [action] widget rendered on the bottom.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    if (exception.type != DioExceptionType.badResponse) {
      if (_connectionCheck(exception)) {
        return AppErrorWidget(
          title: 'No Internet Connection',
          message: 'Check your network provider',
          action: action,
        );
      }

      kLogger.f('DioExceptionWidget', error: exception);
      kLogger.f('DioException.type: ${exception.type}');

      return AppErrorWidget(action: action);
    }

    final response = exception.response!;
    final statusCode = response.statusCode ?? 0;

    kLogger.d('${response.data}');

    return AppHttpErrorWidget(statusCode: statusCode, action: action);
  }

  bool _connectionCheck(DioException exception) {
    return exception.error is SocketException ||
        exception.type == DioExceptionType.connectionError;
  }
}
