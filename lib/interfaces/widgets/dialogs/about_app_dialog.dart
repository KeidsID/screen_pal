import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:screen_pal/configs/asset_paths.dart';
import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/configs/service_locator/locator.dart' as service;

class AboutAppDialog extends StatelessWidget {
  const AboutAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final packageInfo = service.locator<PackageInfo>();

    return AboutDialog(
      applicationName: kAppName,
      applicationVersion: 'v${packageInfo.version}',
      applicationIcon: Image.asset(AssetPaths.appIcon, width: 100, height: 100),
      applicationLegalese: kAppLegalese,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: const Text('https://github.com/KeidsID/screen_pal'),
            onPressed: () async {
              final url = Uri.parse('https://github.com/KeidsID/screen_pal');
              final showSnackBar = ScaffoldMessenger.of(context).showSnackBar;

              if (!await launchUrl(url)) {
                showSnackBar(SnackBar(
                  content: Text('Fail to visit $url. Try again later'),
                ));
              }
            },
          ),
        ),
      ],
    );
  }
}
