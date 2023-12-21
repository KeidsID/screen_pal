import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/core/entities.dart';
import 'package:screen_pal/interfaces/utils/m3_text_styles.dart';
import 'package:screen_pal/interfaces/widgets/errors/sized_dio_exception_widget.dart';

/// {@template interfaces.widgets.errors.SizedExceptionWidget}
/// A widget to display brief info about the error that occurred.
///
/// Suitable for [BasicException]/[BasicHttpException].
///
/// See also:
/// - [SizedDioExceptionWidget], [SizedExceptionWidget] for [DioException].
/// {@endtemplate}
final class SizedExceptionWidget extends SizedExceptionWidgetUIBase {
  /// {@macro interfaces.widgets.errors.SizedExceptionWidget}
  const SizedExceptionWidget(
    this.exception, {
    super.key,
    this.trace,
    super.width,
    super.height,
    super.padding,
    super.action,
  });

  /// {@macro interfaces.widgets.errors.SizedExceptionWidget}
  const SizedExceptionWidget.expand(this.exception,
      {super.key, this.trace, super.padding, super.action})
      : super(width: double.infinity, height: double.infinity);

  /// {@macro interfaces.widgets.errors.SizedExceptionWidget}
  const SizedExceptionWidget.shrink(this.exception,
      {super.key, this.trace, super.padding, super.action})
      : super(width: 0.0, height: 0.0);

  /// {@macro interfaces.widgets.errors.SizedExceptionWidget}
  SizedExceptionWidget.fromSize(this.exception,
      {super.key, this.trace, Size? size, super.padding, super.action})
      : super(width: size?.width, height: size?.height);

  /// {@macro interfaces.widgets.errors.SizedExceptionWidget}
  const SizedExceptionWidget.square(this.exception,
      {super.key, this.trace, double? dimension, super.padding, super.action})
      : super(width: dimension, height: dimension);

  final Object? exception;

  /// Provide [StackTrace] of the error. It can be used for debugging purpose.
  ///
  /// Use [StackTrace.current] if its not in try catch statement.
  final StackTrace? trace;

  @override
  Widget build(BuildContext context) {
    // lint can't detect [exception] type without this
    final e = exception;

    if (e is BasicException) {
      if (e is BasicHttpException) {
        return _ui(statusCode: e.statusCode, title: e.name, message: e.message);
      }

      return _ui(title: e.name, message: e.message);
    }

    kLogger.f(
      'SizedExceptionWidget.error.uncaught',
      error: exception,
      stackTrace: trace,
    );

    return _ui();
  }

  Widget _ui({
    int? statusCode,
    String? title,
    String? message,
  }) {
    return Builder(builder: (context) {
      return DefaultTextStyle.merge(
        style: M3TextStyles.bodyMedium.toStyle(context),
        textAlign: TextAlign.center,
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                statusCode == null
                    ? const SizedBox.shrink()
                    : Text(
                        '$statusCode',
                        style: M3TextStyles.displayMedium.toStyle(context),
                      ),
                Text(
                  title ?? 'Internal App Error',
                  style: M3TextStyles.headlineSmall.toStyle(context),
                ),
                const Divider(),
                Text(message ?? 'Sorry for the inconvenience'),
                ...action == null
                    ? []
                    : [
                        const SizedBox(height: 16.0),
                        action!,
                      ],
              ],
            ),
          ),
        ),
      );
    });
  }
}

abstract base class SizedExceptionWidgetUIBase extends StatelessWidget {
  /// If non-null, requires the child to have exactly this width.
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  final double? height;
  final EdgeInsetsGeometry padding;

  /// Add widget on the bottom. Typically an [ElevatedButton].
  ///
  /// If null, then no [action] widget rendered on the bottom.
  final Widget? action;

  const SizedExceptionWidgetUIBase({
    super.key,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16.0),
    this.action,
  });
}
