import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:screen_pal/common/asset_paths.dart';
import 'package:screen_pal/interfaces/widgets.dart';

enum PolicyType { privacyPolicy, termsOfUse }

class PoliciesDialogView extends StatelessWidget {
  /// Define which content to load.
  final PolicyType policy;

  const PoliciesDialogView(this.policy, {super.key});

  @override
  Widget build(BuildContext context) {
    final assetBundle = DefaultAssetBundle.of(context);

    final Future<String> policyString = policy == PolicyType.privacyPolicy
        ? assetBundle.loadString(AssetPaths.privacyPolicy)
        : assetBundle.loadString(AssetPaths.termsOfUse);

    return Dialog.fullscreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: AppBar(leading: const CloseButton()),
          ),
          Expanded(
            child: FutureBuilder(
              future: policyString,
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (data == null) {
                  return const Center(child: SizedCircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return SizedExceptionWidget(
                    snapshot.error,
                    trace: snapshot.stackTrace,
                  );
                }

                return Markdown(
                  data: data,
                  onTapLink: (_, href, __) async {
                    final showSnackBar =
                        ScaffoldMessenger.of(context).showSnackBar;

                    if (href == null) {
                      showSnackBar(const SnackBar(
                        content: Text(
                          'Internal app Error. '
                          'Sorry fo the inconvenience',
                        ),
                      ));

                      return;
                    }

                    final url = Uri.parse(href);

                    if (!await launchUrl(url)) {
                      showSnackBar(SnackBar(
                        content: Text('Fail to visit $url. Try again later'),
                      ));
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
