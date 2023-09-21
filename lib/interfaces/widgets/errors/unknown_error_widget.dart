import 'package:flutter/material.dart';

class UnknownErrorWidget extends StatelessWidget {
  const UnknownErrorWidget({super.key, this.padding, this.action});

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
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Internal App Error', style: theme.textTheme.headlineSmall),
            const Divider(),
            const Text('Sorry for the inconvenience'),
            const SizedBox(height: 16.0),
            action ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
