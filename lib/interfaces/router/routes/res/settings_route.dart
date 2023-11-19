// coverage:ignore-file

part of '../routes.dart';

final _settingsRoute = GoRoute(
  path: '/settings',
  builder: (_, __) => const SettingsView(),
  routes: [
    GoRoute(
      path: 'about-app',
      pageBuilder: (_, __) {
        return DialogPage(builder: (_) => const AboutAppDialog());
      },
      routes: [
        GoRoute(
          path: 'privacy-policy',
          pageBuilder: (_, __) => DialogPage(
            builder: (_) => const PoliciesDialog(PolicyType.privacyPolicy),
          ),
        ),
        GoRoute(
          path: 'terms-of-use',
          pageBuilder: (_, __) => DialogPage(
            builder: (_) => const PoliciesDialog(PolicyType.termsOfUse),
          ),
        )
      ],
    ),
    GoRoute(
      path: 'about-tmdb',
      pageBuilder: (_, __) {
        return DialogPage(builder: (_) => const AboutTmdbDialog());
      },
    ),
  ],
);
