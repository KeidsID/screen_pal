import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:screen_pal/interfaces/router/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:screen_pal/common/asset_paths.dart';
import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/infrastructures/container/container.dart' as service;

class AboutAppDialogView extends StatelessWidget {
  const AboutAppDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    final packageInfo = service.locator<PackageInfo>();

    return AboutDialog(
      applicationName: kAppName,
      applicationVersion: 'v${packageInfo.version}',
      applicationIcon: Image.asset(AssetPaths.appIcon, width: 100, height: 100),
      applicationLegalese: kAppLegalese,
      children: [
        const SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextButton(
              child: const Text('Privacy Policy'),
              onPressed: () => const PrivacyPolicyRoute().go(context),
            ),
            TextButton(
              child: const Text('Terms of Use'),
              onPressed: () => const TermsOfUseRoute().go(context),
            ),
            TextButton(
              child: const Text('Source Code'),
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
          ],
        )
      ],
    );
  }
}
