import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_pal/configs/asset_paths.dart';
import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/interfaces/utils/tmdb_logo_shader_mask.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTmdbDialog extends StatelessWidget {
  const AboutTmdbDialog({super.key});

  static const _aboutTMDB =
      "The Movie Database (TMDB) is a community built movie and TV database. "
      "Every piece of data has been added by our amazing community dating back "
      "to 2008.";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final materialL10n = MaterialLocalizations.of(context);

    return AlertDialog(
      scrollable: true,
      content: ListBody(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TmdbLogoShaderMask(
                child: SvgPicture.asset(
                  AssetPaths.tmdbPrimaryFullIcon,
                  width: 80,
                  height: 80,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListBody(
                    children: <Widget>[
                      Text('The Movie DB', style: textTheme.headlineSmall),
                      Text(
                        'API v$kTmdbApiVersion',
                        style: textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 18.0),
                      Text(_aboutTMDB, style: textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Visit TMDB'),
          onPressed: () async {
            final url = Uri.parse('https://www.themoviedb.org');
            final showSnackBar = ScaffoldMessenger.of(context).showSnackBar;

            if (!await launchUrl(url)) {
              showSnackBar(SnackBar(
                content: Text('Fail to visit $url. Try again later'),
              ));
            }
          },
        ),
        TextButton(
          child: Text(materialL10n.closeButtonLabel),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}