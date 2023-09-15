import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:screen_pal/configs/constants.dart';

import 'package:screen_pal/interfaces/widgets/theme_mode_dropdown_button.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      const ListTile(
        leading: Icon(Icons.color_lens_outlined),
        title: Text('App Theme'),
        trailing: ThemeModeDropdownButton(),
      ),
      ListTile(
        leading: const Icon(Icons.info_outlined),
        title: const Text('About App'),
        onTap: () async {
          final packageInfo = await PackageInfo.fromPlatform();
          final appVersion = packageInfo.version;

          void toPreventAsyncGap() {
            showAboutDialog(
              context: context,
              applicationName: kAppName,
              applicationIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Image.asset(
                  'assets/images/app-icon.png',
                  width: 80,
                  height: 80,
                ),
              ),
              applicationLegalese:
                  'Screen Pal is a movies and TV shows app that provides '
                  'in-depth information about movies and TV shows.',
              applicationVersion: 'v$appVersion',
            );
          }

          toPreventAsyncGap();
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/movies')),
        title: const Text('Settings'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
