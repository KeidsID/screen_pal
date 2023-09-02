import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/widgets/carousel/movies_carousel.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../helpers/dummy/dummy_movies.dart';

void main() {
  Widget testWidgetApp(List<Movie> movies) {
    return MaterialApp(
      home: Scaffold(
        body: MoviesCarousel(
          movies: movies,
          autoPlay: false,
          enableInfiniteScroll: false,
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
          tester.widget(_WidgetFinders.movieImage.last),
          isA<DefaultNetworkImage>().having(
            (e) => e.imageUrl,
            'image url',
            '$tmdbImageBaseUrl${dummyMovie.backdropPath}',
          ),
        );

        expect(
          tester.widget(_WidgetFinders.movieDetailColumn.last),
          isA<Column>()
              .having(
                (e) => e.children[0],
                'children[0]',
                isA<Text>().having(
                  (e) => e.data,
                  'movie title',
                  dummyMovie.title,
                ),
              )
              .having(
                (e) => e.children[1],
                'children[1]',
                isA<Text>().having(
                  (e) => e.data,
                  'other movie details that seperated by bullets (" • ")',
                  [
                    dummyMovie.releaseDate?.year ?? 'Coming Soon',
                    '${dummyMovie.voteAverage * 10}%'
                  ].join(' • '),
                ),
              ),
        );
      }),
    );

    testWidgets(
      'on Thin Device (width < 800) '
      'should render [Stack] and not contain movie overview',
      (tester) => mockNetworkImagesFor(() async {
        final dpi = tester.view.devicePixelRatio;
        tester.view.physicalSize = Size(768 * dpi, 476 * dpi);

        await tester.pumpWidget(testWidgetApp(dummyMovies));

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

        await tester.pumpWidget(testWidgetApp(dummyMovies));

        await expectLater(
          tester.widget(_WidgetFinders.contentContainer.last),
          isA<Card>(),
        );

        await expectLater(_WidgetFinders.movieOverview, findsWidgets);
      }),
    );

    // pumpAndSettle keeps timed out.
    // testWidgets(
    //   'indicator should render and animate the carousel correctly',
    //   (tester) => mockNetworkImagesFor(() async {
    //     await tester.pumpWidget(testWidgetApp(dummyMovies));

    //     // expect initial index
    //     expect(
    //       tester.state(_WidgetFinders.carousel),
    //       isA<MoviesCarouselState>().having(
    //         (e) => e.currentIndex,
    //         'carousel current index',
    //         0,
    //       ),
    //     );
    //     expect(
    //       tester.widget(_WidgetFinders.indicator),
    //       isA<AnimatedSmoothIndicator>().having(
    //         (e) => e.activeIndex,
    //         'indicator current index',
    //         0,
    //       ),
    //     );

    //     // tap last indicator dot
    //     await tester.tap(find.byType(SmoothIndicator).last);
    //     await tester.pumpAndSettle();

    //     // expect index changes
    //     expect(
    //       tester.state(_WidgetFinders.carousel),
    //       isA<MoviesCarouselState>().having(
    //         (e) => e.currentIndex,
    //         'carousel current index',
    //         1,
    //       ),
    //     );
    //     expect(
    //       tester.widget(_WidgetFinders.indicator),
    //       isA<AnimatedSmoothIndicator>().having(
    //         (e) => e.activeIndex,
    //         'indicator current index',
    //         1,
    //       ),
    //     );
    //   }),
    // );
  });
}

abstract class _WidgetFinders {
  static Finder get carousel => find.byType(MoviesCarousel);
  static Finder get indicator => find.byType(AnimatedSmoothIndicator);

  /// Include movie image and detail.
  static Finder get contentContainer =>
      find.byKey(const Key('content-container'));
  static Finder get movieImage => find.byKey(const Key('image-widget'));
  static Finder get movieDetailColumn => find.byKey(const Key('detail-column'));
  static Finder get movieOverview => find.byKey(const Key('movie-overview'));
}
