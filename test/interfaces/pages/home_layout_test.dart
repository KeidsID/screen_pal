import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/interfaces/pages/home_layout.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final backButton = Builder(
    builder: (context) => ElevatedButton(
      onPressed: () => context.go('/movies'),
      child: const Text('back-button'),
    ),
  );

  GoRouterWidgetBuilder dummyPageBuilder(String id) {
    return (_, __) {
      return Scaffold(
        body: Center(
          child: Column(children: [Text(id), backButton]),
        ),
      );
    };
  }

  final dummyRouter = GoRouter(
    initialLocation: '/movies',
    routes: [
      ShellRoute(
        builder: (_, __, child) {
          return HomeLayout(child: child);
        },
        routes: [
          GoRoute(path: '/movies', builder: dummyPageBuilder('movies-page')),
          GoRoute(path: '/tv_shows', builder: dummyPageBuilder('tv-shows-page'))
        ],
      ),
      GoRoute(path: '/settings', builder: dummyPageBuilder('settings-page')),
    ],
  );

  final testWidgetApp = MaterialApp.router(routerConfig: dummyRouter);

  group('HomeLayout widget', () {
    testWidgets(
      'on Thin Device (width < 600)'
      'should render BottomNavigationBar',
      (tester) async {
        final dpi = tester.view.devicePixelRatio;
        tester.view.physicalSize = Size(412 * dpi, 915 * dpi);

        await tester.pumpWidget(testWidgetApp);

        await expectLater(
          tester.widget(_WidgetFinders.navBar),
          isA<BottomNavigationBar>(),
        );
      },
    );

    testWidgets(
      'on Wide Device (width >= 600)'
      'should render NavigationRail',
      (tester) async {
        final dpi = tester.view.devicePixelRatio;
        tester.view.physicalSize = Size(1024 * dpi, 600 * dpi);

        await tester.pumpWidget(testWidgetApp);

        await expectLater(
          tester.widget(_WidgetFinders.navBar),
          isA<NavigationRail>(),
        );
      },
    );

    testWidgets(
      'should act as the home page navigator',
      (tester) async {
        await tester.pumpWidget(testWidgetApp);
        // expect all the nav widgets (movies, tv_shows, and settings)
        expect(_WidgetFinders.moviesNav, findsOneWidget);
        expect(_WidgetFinders.seriesNav, findsOneWidget);
        expect(_WidgetFinders.settingsNav, findsOneWidget);

        // expect initial page
        expect(_WidgetFinders.moviesPage, findsOneWidget);

        // navigate to '/tv_shows' route
        await tester.tap(_WidgetFinders.seriesNav);
        await tester.pumpAndSettle();

        // still expect all the nav widgets
        expect(_WidgetFinders.moviesNav, findsOneWidget);
        expect(_WidgetFinders.seriesNav, findsOneWidget);
        expect(_WidgetFinders.settingsNav, findsOneWidget);

        // expect '/tv_shows' route page.
        expect(_WidgetFinders.seriesPage, findsOneWidget);

        // navigate to '/settings' route
        await tester.tap(_WidgetFinders.settingsNav);
        await tester.pumpAndSettle();

        // expect '/settings' route page.
        expect(_WidgetFinders.settingsPage, findsOneWidget);

        // navigate back to '/movies' route.
        await tester.tap(_WidgetFinders.backButton);
        await tester.pumpAndSettle();

        // expect all the nav widgets (movies, tv_shows, and settings)
        expect(_WidgetFinders.moviesNav, findsOneWidget);
        expect(_WidgetFinders.seriesNav, findsOneWidget);
        expect(_WidgetFinders.settingsNav, findsOneWidget);

        // expect initial page
        expect(_WidgetFinders.moviesPage, findsOneWidget);
      },
    );
  });
}

abstract class _WidgetFinders {
  static get backButton => find.text('back-button');

  static get moviesPage => find.text('movies-page');
  static get seriesPage => find.text('tv-shows-page');
  static get settingsPage => find.text('settings-page');

  static get navBar => find.byKey(const Key('navigation-bar'));
  static get moviesNav => find.byIcon(Icons.movie_outlined);
  static get seriesNav => find.byIcon(Icons.tv_outlined);
  static get settingsNav => find.byIcon(Icons.settings);
}
