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
    ),
    GoRoute(
      path: 'about-tmdb',
      pageBuilder: (_, __) {
        return DialogPage(builder: (_) => const AboutTmdbDialog());
      },
    ),
  ],
);
