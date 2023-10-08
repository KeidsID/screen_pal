import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:screen_pal/core/entities/products/product.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/extras/genres_providers.dart';
import 'package:screen_pal/interfaces/providers/extras/languages_provider.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';
import 'package:screen_pal/interfaces/widgets/products/products_carousel.dart';

import '../../../helpers/dummy/dummy_genres.dart';
import '../../../helpers/dummy/dummy_languages.dart';
import '../../../helpers/dummy/dummy_movies.dart';
import '../../../helpers/providers/fake_languages_notifier.dart';
import '../../../helpers/providers/fake_movie_genres_notifier.dart';

void main() {
  Widget testWidgetApp(List<Product> products) {
    return ProviderScope(
      overrides: [
        languagesProvider.overrideWith(() => FakeLanguagesNotifier()),
        movieGenresProvider.overrideWith(() => FakeMovieGenresNotifier())
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
          isA<DefaultNetworkImage>().having(
            (e) => e.imageUrl,
            'image url',
            '$tmdbImageBaseUrl${dummyMovie.backdropPath}',
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

        final extras = [
          dummyMovie.releaseDate?.year ?? 'Coming Soon',
          language,
          genreNames.isEmpty ? '...' : genreNames.join(', '),
        ].join(' • ');

        expect(
          tester.widget(_WidgetFinders.productExtras.last),
          isA<Text>().having((e) => e.data, 'product extras detail', extras),
        );
      }),
    );

    testWidgets(
      'on Thin Device (width < 800) '
      'should render [Stack] and not contain product overview',
      (tester) => mockNetworkImagesFor(() async {
        final dpi = tester.view.devicePixelRatio;
        tester.view.physicalSize = Size(768 * dpi, 476 * dpi);

        await tester.pumpWidget(testWidgetApp([dummyMovie]));

        await expectLater(
          tester.widget(_WidgetFinders.contentContainer.last),
          isA<Stack>(),
        );

        await expectLater(_WidgetFinders.productOverview, findsNothing);
      }),
    );

    testWidgets(
      'on Wide Device (width >= 800) '
      'should render [Card] and contain product overview',
      (tester) => mockNetworkImagesFor(() async {
        final dpi = tester.view.devicePixelRatio;
        tester.view.physicalSize = Size(1024 * dpi, 635 * dpi);

        await tester.pumpWidget(testWidgetApp([dummyMovie]));

        await expectLater(
          tester.widget(_WidgetFinders.contentContainer.last),
          isA<Card>(),
        );

        await expectLater(_WidgetFinders.productOverview, findsWidgets);
      }),
    );
  });
}

abstract class _WidgetFinders {
  static Finder get contentContainer =>
      find.byKey(const Key('content-container'));

  static Finder get image => find.byKey(const Key('image-widget'));
  static Finder get productTitle => find.byKey(const Key('product-title'));
  static Finder get productExtras => find.byKey(const Key('product-extras'));
  static Finder get productOverview =>
      find.byKey(const Key('product-overview'));
}
