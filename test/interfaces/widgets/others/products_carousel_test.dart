import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:screen_pal/interfaces/providers/remote/extras/extras_providers.dart';
import 'package:screen_pal/interfaces/widgets/common/common_network_image.dart';
import 'package:screen_pal/interfaces/widgets/others/products/products_carousel.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

import '../../../helpers/dummy/dummy_genres.dart';
import '../../../helpers/dummy/dummy_languages.dart';
import '../../../helpers/dummy/dummy_movies.dart';
import '../../../helpers/tester/tester_view_emulators.dart';

abstract class _WidgetFinders {
  static Finder get contentContainer =>
      find.byKey(const Key('content-container')).last;

  static Finder get image => find.byKey(const Key('image-widget'));
  static Finder get productTitle => find.byKey(const Key('product-title'));
  static Finder get productExtras => find.byKey(const Key('product-extras'));
  static Finder get productOverview =>
      find.byKey(const Key('product-overview'));
}

void main() {
  EquatableConfig.stringify = true;

  Widget testWidgetApp(List<Product> products) {
    return ProviderScope(
      overrides: [
        movieExtrasProvider.overrideWith((ref) {
          return Extras(languages: dummyLanguages, genres: dummyGenres);
        }),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: ProductsCarousel(
            products,
            autoPlay: false,
            enableInfiniteScroll: false,
          ),
        ),
      ),
    );
  }

  group('ProductsCarousel widget', () {
    testWidgets(
      'should render product contents correctly',
      (tester) => mockNetworkImagesFor(() async {
        await tester.pumpWidget(testWidgetApp([dummyMovie]));

        expect(
          tester.widget(_WidgetFinders.image.last),
          isA<CommonNetworkImage>().having(
            (e) => e.imageUrl,
            'image url',
            '${dummyMovie.backdropImageUrl}',
          ),
        );

        expect(
          tester.widget(_WidgetFinders.productTitle.last),
          isA<Text>().having(
            (e) => e.data,
            'product title',
            dummyMovie.title,
          ),
        );

        String language = dummyLanguages.firstWhere((e) {
          return e.iso6391 == dummyMovie.language;
        }).englishName;

        List<String> genreNames = dummyMovie.genreIds.map((id) {
          return dummyGenres.firstWhere((e) => e.id == id).name;
        }).toList();

        final expectedExtrasText = [
          dummyMovie.releaseDate?.year ?? 'Coming Soon',
          language,
          genreNames.isEmpty ? '...' : genreNames.join(', '),
        ].join(' • ');

        expect(
          tester.widget(_WidgetFinders.productExtras.last),
          isA<Text>().having(
            (e) => e.data,
            'product extras detail',
            expectedExtrasText,
          ),
        );
      }),
    );

    group('should render [Stack] and not contain product overview', () {
      Future<void> expectStackAndNoOverviewLater(WidgetTester tester) async {
        await expectLater(
          tester.widget(_WidgetFinders.contentContainer.last),
          isA<Stack>(),
        );

        await expectLater(_WidgetFinders.productOverview, findsNothing);
      }

      testWidgets('on Mobile device', (tester) {
        return mockNetworkImagesFor(() async {
          TesterViewEmulators.samsungGalaxyS20Ultra(tester);

          await tester.pumpWidget(testWidgetApp([dummyMovie]));

          await expectStackAndNoOverviewLater(tester);
        });
      });
      testWidgets('on Tablet device', (tester) {
        return mockNetworkImagesFor(() async {
          TesterViewEmulators.galaxyTabS4(tester);

          await tester.pumpWidget(testWidgetApp([dummyMovie]));

          await expectStackAndNoOverviewLater(tester);
        });
      });
    });

    group('should render [Card] and contain product overview', () {
      Future<void> expectCardAndOverviewLater(WidgetTester tester) async {
        await expectLater(
          tester.widget(_WidgetFinders.contentContainer.last),
          isA<Card>(),
        );

        await expectLater(_WidgetFinders.productOverview, findsWidgets);
      }

      testWidgets('on Tablet L (potrait) device', (tester) {
        return mockNetworkImagesFor(() async {
          TesterViewEmulators.iPadPro(tester);

          await tester.pumpWidget(testWidgetApp([dummyMovie]));

          await expectCardAndOverviewLater(tester);
        });
      });
      testWidgets('on Tablet L (landscape)/Laptop device', (tester) {
        return mockNetworkImagesFor(() async {
          TesterViewEmulators.iPadPro(tester, isPotrait: false);

          await tester.pumpWidget(testWidgetApp([dummyMovie]));

          await expectCardAndOverviewLater(tester);
        });
      });

      testWidgets('on Laptop L device', (tester) {
        return mockNetworkImagesFor(() async {
          TesterViewEmulators.asusVivobook14(tester);

          await tester.pumpWidget(testWidgetApp([dummyMovie]));

          await expectCardAndOverviewLater(tester);
        });
      });
    });
  });
}
