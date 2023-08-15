import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/interfaces/pages/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: () => context.go('/settings'),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: const Center(child: Text('Hello World!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
