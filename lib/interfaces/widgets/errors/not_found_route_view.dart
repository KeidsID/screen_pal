import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundRouteView extends StatelessWidget {
  const NotFoundRouteView({super.key, required this.routePath});

  final String routePath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('404', style: theme.textTheme.displayMedium),
          Text('Not Found', style: theme.textTheme.headlineSmall),
          const Divider(),
          Text('No resource found on "$routePath" path.'),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home),
            label: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }
}