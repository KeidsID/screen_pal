import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/utils/m3_text_styles.dart';
import 'package:screen_pal/interfaces/widgets/errors/app_http_error_widget.dart';

class AppErrorWidget extends StatelessWidget {
  /// Create a widget to display brief info about the error that occurred.
  ///
  /// See also:
  ///
  ///  * [AppHttpErrorWidget], a widget to display brief info about the HTTP
  ///    error that occurred.
  const AppErrorWidget({
    super.key,
    this.title = 'Internal App Error',
    this.message = 'Sorry for the inconvenience',
    this.padding,
    this.action,
  });

  /// Title that explains the error in one short sentence.
  final String title;

  /// {@template screen_pal.interfaces.widgets.errors.AppErrorWidget.message}
  /// Aditional message for error details.
  /// {@endtemplate}
  final String message;

  final EdgeInsetsGeometry? padding;

  /// {@template screen_pal.interfaces.widgets.errors.AppErrorWidget.action}
  /// Add widget on the bottom. Typically an [ElevatedButton].
  ///
  /// If null, then no [action] widget rendered on the bottom.
  /// {@endtemplate}
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: M3TextStyles.headlineSmall.toStyle(context)),
            const Divider(),
            Text(message),
            const SizedBox(height: 16.0),
            action ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
