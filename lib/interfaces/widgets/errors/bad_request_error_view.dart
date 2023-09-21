import 'package:flutter/material.dart';

/// Widget that displays the `400 Bad Request` error with optional [message]
/// and [action].
class BadRequestErrorView extends StatelessWidget {
  /// Create a widget that display a `400 Bad Request` error with optional
  /// [message] and [action].
  const BadRequestErrorView({super.key, this.message, this.action});

  /// A message describing the error.
  final String? message;

  /// Add widget on the bottom. Typically an [ElevatedButton].
  ///
  /// If null, then no [action] widget rendered on the bottom.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('400', style: theme.textTheme.displayMedium),
            Text('Bad Request', style: theme.textTheme.headlineSmall),
            const Divider(),
            Text(message ?? 'Sorry for the inconvenience'),
            const SizedBox(height: 16.0),
            action ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
