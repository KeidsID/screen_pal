part of '../../routes.dart';

/// {@template interfaces.router.routes.settings_route}
/// `/settings` route.
/// {@endtemplate}
final class SettingsRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.settings_route}
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsView();
  }
}

/// {@template interfaces.router.routes.about_app_route}
/// `/settings/about-app` route.
/// {@endtemplate}
final class AboutAppRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.about_app_route}
  const AboutAppRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage(builder: (_) => const AboutAppDialogView());
  }
}

/// {@template interfaces.router.routes.privacy_policy_route}
/// `/settings/about-app/privacy-policy` route.
/// {@endtemplate}
final class PrivacyPolicyRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.privacy_policy_route}
  const PrivacyPolicyRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage(builder: (_) {
      return const PoliciesDialogView(PolicyType.privacyPolicy);
    });
  }
}

/// {@template interfaces.router.routes.terms_of_use_route}
/// `/settings/about-app/terms-of-use` route.
/// {@endtemplate}
final class TermsOfUseRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.terms_of_use_route}
  const TermsOfUseRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage(builder: (_) {
      return const PoliciesDialogView(PolicyType.termsOfUse);
    });
  }
}

/// {@template interfaces.router.routes.about_tmdb_route}
/// `/settings/about-tmdb` route.
/// {@endtemplate}
final class AboutTmdbRoute extends GoRouteData {
  /// {@macro interfaces.router.routes.about_tmdb_route}
  const AboutTmdbRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage(builder: (_) => const AboutTmdbDialogView());
  }
}
