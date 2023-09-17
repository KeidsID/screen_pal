import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    );
  }
}
