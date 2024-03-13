import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/infrastructures/tmdb/errors/common_response_exception.dart';
import 'package:screen_pal/interfaces/widgets/errors/sized_exception_widget.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

/// {@template interfaces.widgets.errors.SizedDioExceptionWidget}
/// [SizedExceptionWidget] for [DioException].
/// {@endtemplate}
final class SizedDioExceptionWidget extends SizedExceptionWidgetUIBase {
  /// {@macro interfaces.widgets.errors.SizedDioExceptionWidget}
  const SizedDioExceptionWidget(
    this.exception, {
    super.key,
    super.width,
    super.height,
    super.padding,
    super.action,
  });

  /// {@macro interfaces.widgets.errors.SizedDioExceptionWidget}
  const SizedDioExceptionWidget.expand(this.exception,
      {super.key, super.padding, super.action})
      : super(width: double.infinity, height: double.infinity);

  /// {@macro interfaces.widgets.errors.SizedDioExceptionWidget}
  const SizedDioExceptionWidget.shrink(this.exception,
      {super.key, super.padding, super.action})
      : super(width: 0.0, height: 0.0);

  /// {@macro interfaces.widgets.errors.SizedDioExceptionWidget}
  SizedDioExceptionWidget.fromSize(this.exception,
      {super.key, Size? size, super.padding, super.action})
      : super(width: size?.width, height: size?.height);

  /// {@macro interfaces.widgets.errors.SizedDioExceptionWidget}
  const SizedDioExceptionWidget.square(this.exception,
      {super.key, double? dimension, super.padding, super.action})
      : super(width: dimension, height: dimension);

  final DioException exception;

  @override
  Widget build(BuildContext context) {
    if (exception.type != DioExceptionType.badResponse) {
      if (_connectionCheck(exception)) {
        return SizedExceptionWidget(
          const BasicException(
            name: 'No Internet Connection',
            message: 'Check your network provider',
          ),
          trace: StackTrace.current,
          width: width,
          height: height,
          padding: padding,
          action: action,
        );
      }

      return SizedExceptionWidget(
        exception,
        trace: exception.stackTrace,
        width: width,
        height: height,
        padding: padding,
        action: action,
      );
    }

    final res = exception.response!;
    final statusCode = res.statusCode;

    try {
      final resBody = CommonResponseException.fromJson(jsonDecode(res.data));

      return SizedExceptionWidget(
        BasicHttpException(
          statusCode: statusCode,
          message: resBody.statusMessage,
        ),
        trace: StackTrace.current,
        width: width,
        height: height,
        padding: padding,
        action: action,
      );
    } catch (e, trace) {
      // incase [CommonResponseException] are not valid.

      return SizedExceptionWidget(
        e,
        trace: trace,
        width: width,
        height: height,
        padding: padding,
        action: action,
      );
    }
  }

  bool _connectionCheck(DioException exception) {
    return exception.type == DioExceptionType.connectionError ||
        exception.type == DioExceptionType.connectionTimeout;
  }
}
