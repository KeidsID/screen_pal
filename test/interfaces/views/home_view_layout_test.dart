import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/interfaces/views/others/home_view_layout.dart';

import '../../helpers/tester/tester_view_emulators.dart';

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
          return HomeViewLayout(child: child);
        },
        routes: [
          GoRoute(path: '/movies', builder: dummyPageBuilder('movies-page')),
          GoRoute(path: '/tv-shows', builder: dummyPageBuilder('tv-shows-page'))
        ],
      ),
      GoRoute(path: '/settings', builder: dummyPageBuilder('settings-page')),
    ],
  );

  final testWidgetApp = MaterialApp.router(routerConfig: dummyRouter);

  group('HomeLayout widget', () {
    group('should render BottomNavigationBar', () {
      Future<void> expectBottomNavigationBar(WidgetTester tester) {
        return expectLater(
          tester.widget(_WidgetFinders.navBar),
          isA<BottomNavigationBar>(),
        );
      }

      testWidgets('on Mobile device', (tester) async {
        TesterViewEmulators.samsungGalaxyS20Ultra(tester);

        await tester.pumpWidget(testWidgetApp);

        await expectBottomNavigationBar(tester);
      });
    });

    group('should render NavigationRail', () {
      Future<void> expectNavigationRail(WidgetTester tester) {
        return expectLater(
          tester.widget(_WidgetFinders.navBar),
          isA<NavigationRail>(),
        );
      }

      testWidgets('on Mobile device (landscape)', (tester) async {
        TesterViewEmulators.samsungGalaxyS20Ultra(
          tester,
          isPotrait: false,
        );

        await tester.pumpWidget(testWidgetApp);

        await expectNavigationRail(tester);
      });
      testWidgets('on Tablet device', (tester) async {
        TesterViewEmulators.galaxyTabS4(tester);

        await tester.pumpWidget(testWidgetApp);

        await expectNavigationRail(tester);
      });
      testWidgets('on Laptop device', (tester) async {
        TesterViewEmulators.asusVivobook14(tester);

        await tester.pumpWidget(testWidgetApp);

        await expectNavigationRail(tester);
      });
    });

    testWidgets(
      'should act as the home page navigator',
      (tester) async {
        await tester.pumpWidget(testWidgetApp);
        // expect all the nav widgets (movies, tv-shows, and settings)
        expect(_WidgetFinders.moviesNav, findsOneWidget);
        expect(_WidgetFinders.seriesNav, findsOneWidget);
        expect(_WidgetFinders.settingsNav, findsOneWidget);

        // expect initial page
        expect(_WidgetFinders.moviesPage, findsOneWidget);

        // navigate to '/tv-shows' route
        await tester.tap(_WidgetFinders.seriesNav);
        await tester.pumpAndSettle();

        // still expect all the nav widgets
        expect(_WidgetFinders.moviesNav, findsOneWidget);
        expect(_WidgetFinders.seriesNav, findsOneWidget);
        expect(_WidgetFinders.settingsNav, findsOneWidget);

        // expect '/tv-shows' route page.
        expect(_WidgetFinders.tvShowsPage, findsOneWidget);

        // navigate to '/settings' route
        await tester.tap(_WidgetFinders.settingsNav);
        await tester.pumpAndSettle();

        // expect '/settings' route page.
        expect(_WidgetFinders.settingsPage, findsOneWidget);

        // navigate back to '/movies' route.
        await tester.tap(_WidgetFinders.backButton);
        await tester.pumpAndSettle();

        // expect all the nav widgets (movies, tv-shows, and settings)
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
  static get tvShowsPage => find.text('tv-shows-page');
  static get settingsPage => find.text('settings-page');

  static get navBar => find.byKey(const Key('navigation-bar'));
  static get moviesNav => find.byIcon(Icons.movie_outlined);
  static get seriesNav => find.byIcon(Icons.tv_outlined);
  static get settingsNav => find.byIcon(Icons.settings);
}
