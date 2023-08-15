import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundRoutePage extends StatelessWidget {
  const NotFoundRoutePage({super.key, required this.routePath});

  final String routePath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('404', style: theme.textTheme.headlineLarge),
          Text('Not Found', style: theme.textTheme.headlineSmall),
          const Divider(),
          Text('The requested URL "$routePath" was not found on this server.'),
          const SizedBox(height: 16.0),
          FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }
}
