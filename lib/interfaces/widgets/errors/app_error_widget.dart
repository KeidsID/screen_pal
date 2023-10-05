import 'package:flutter/material.dart';

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

  /// Aditional message for error details.
  final String message;

  final EdgeInsetsGeometry? padding;

  /// Add widget on the bottom. Typically an [ElevatedButton].
  ///
  /// If null, then no [action] widget rendered on the bottom.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox.expand(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: theme.textTheme.headlineSmall),
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
