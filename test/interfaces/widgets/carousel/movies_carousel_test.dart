import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/extras/genres_providers.dart';
import 'package:screen_pal/interfaces/providers/extras/languages_provider.dart';
import 'package:screen_pal/interfaces/widgets/carousel/movies_carousel.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';

import '../../../helpers/dummy/dummy_genres.dart';
import '../../../helpers/dummy/dummy_languages.dart';
import '../../../helpers/dummy/dummy_movies.dart';
import '../../../helpers/providers/fake_languages_notifier.dart';
import '../../../helpers/providers/fake_movie_genres_notifier.dart';

void main() {
  Widget testWidgetApp(List<Movie> movies) {
    return ProviderScope(
      overrides: [
        languagesProvider.overrideWith(() => FakeLanguagesNotifier()),
        movieGenresProvider.overrideWith(() => FakeMovieGenresNotifier())
      ],
      child: MaterialApp(
        home: Scaffold(
          body: MoviesCarousel(
            movies: movies,
            autoPlay: false,
            enableInfiniteScroll: false,
          ),
        ),
      ),
    );
  }

  group('MoviesCarousel widget', () {
    testWidgets(
      'should render movie contents correctly',
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
          tester.widget(_WidgetFinders.movieTitle.last),
          isA<Text>().having(
            (e) => e.data,
            'movie title',
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
          tester.widget(_WidgetFinders.movieExtras.last),
          isA<Text>().having((e) => e.data, 'movie extras detail', extras),
        );
      }),
    );

    testWidgets(
      'on Thin Device (width < 800) '
      'should render [Stack] and not contain movie overview',
      (tester) => mockNetworkImagesFor(() async {
        final dpi = tester.view.devicePixelRatio;
        tester.view.physicalSize = Size(768 * dpi, 476 * dpi);

        await tester.pumpWidget(testWidgetApp([dummyMovie]));

        await expectLater(
          tester.widget(_WidgetFinders.contentContainer.last),
          isA<Stack>(),
        );

        await expectLater(_WidgetFinders.movieOverview, findsNothing);
      }),
    );

    testWidgets(
      'on Wide Device (width >= 800) '
      'should render [Card] and contain movie overview',
      (tester) => mockNetworkImagesFor(() async {
        final dpi = tester.view.devicePixelRatio;
        tester.view.physicalSize = Size(1024 * dpi, 635 * dpi);

        await tester.pumpWidget(testWidgetApp([dummyMovie]));

        await expectLater(
          tester.widget(_WidgetFinders.contentContainer.last),
          isA<Card>(),
        );

        await expectLater(_WidgetFinders.movieOverview, findsWidgets);
      }),
    );
  });
}

abstract class _WidgetFinders {
  static Finder get contentContainer =>
      find.byKey(const Key('content-container'));

  static Finder get image => find.byKey(const Key('image-widget'));
  static Finder get movieTitle => find.byKey(const Key('movie-title'));
  static Finder get movieExtras => find.byKey(const Key('movie-extras'));
  static Finder get movieOverview => find.byKey(const Key('movie-overview'));
}
