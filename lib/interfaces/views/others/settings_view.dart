import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/router/app_navigator.dart';
import 'package:screen_pal/interfaces/widgets/others/theme_mode_dropdown_button.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          const ListTile(
            leading: Icon(Icons.color_lens_outlined),
            title: Text('App Theme'),
            trailing: ThemeModeDropdownButton(),
          ),
          ListTile(
            leading: const Icon(Icons.info_outlined),
            title: const Text('About App'),
            onTap: () => AppNavigator.aboutApp(context),
          ),
          ListTile(
            leading: const Icon(Icons.info_outlined),
            title: const Text('About TMDB'),
            onTap: () => AppNavigator.aboutTmdb(context),
          ),
        ],
      ),
    );
  }
}
