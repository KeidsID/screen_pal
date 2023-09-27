import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/extras/extras_providers.dart';
import 'package:screen_pal/interfaces/router/app_navigator.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';

// Tests Utils:

/// To check which layout are rendered.
const _contentContainerKey = Key('content-container');

// To check movie contents:

const _imageKey = Key('image-widget');
const _movieTitleKey = Key('movie-title');
const _movieExtrasKey = Key('movie-extras');
const _movieOverviewKey = Key('movie-overview');

class MoviesCarousel extends ConsumerStatefulWidget {
  /// Create a Carousel widget that displays basic information of the movies
  /// provided.
  ///
  /// Max number of movies are 10. To make sure the indicator not overflow
  /// from the screen.
  const MoviesCarousel({
    super.key,
    required this.movies,
    this.enableInfiniteScroll = true,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
  }) : assert(movies.length <= 10);

  final List<Movie> movies;

  /// Determines if carousel should loop infinitely or be limited to item length.
  ///
  /// Defaults to true, i.e. infinite loop.
  final bool enableInfiniteScroll;

  /// Enables auto play, sliding one page at a time.
  ///
  /// Use [autoPlayInterval] to determent the frequency of slides. Defaults to false.
  final bool autoPlay;

  /// Sets Duration to determent the frequency of slides when
  ///
  /// [autoPlay] is set to true.
  /// Defaults to 4 seconds.
  final Duration autoPlayInterval;

  /// The animation duration between two transitioning pages while in auto playback.
  ///
  /// Defaults to 800 ms.
  final Duration autoPlayAnimationDuration;

  @override
  ConsumerState<MoviesCarousel> createState() => _MoviesCarouselState();
}

class _MoviesCarouselState extends ConsumerState<MoviesCarousel> {
  /// Carousel current index
  int currentIndex = 0;
  final _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final isThin = deviceSize.width < 800.0;

    final deviceH = deviceSize.height;
    const minH = 400.0;
    const maxH = 800.0;

    const takenH = 0.75; // in percent

    final carouselHeight = deviceH < minH
        ? minH * takenH
        : deviceH >= maxH
            ? maxH * takenH
            : deviceH * takenH;

    return Padding(
      padding: EdgeInsets.only(top: isThin ? 0.0 : 16.0),
      child: Column(
        children: [
          CarouselSlider.builder(
            carouselController: _controller,
            options: CarouselOptions(
              enableInfiniteScroll: widget.enableInfiniteScroll,
              height: carouselHeight,
              enlargeCenterPage: isThin ? false : true,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              viewportFraction: isThin ? 1 : 0.95,
              autoPlay: widget.autoPlay,
              autoPlayInterval: widget.autoPlayInterval,
              autoPlayAnimationDuration: widget.autoPlayAnimationDuration,
              onPageChanged: (index, _) => setState(() => currentIndex = index),
            ),
            itemCount: widget.movies.length,
            itemBuilder: (context, index, realIndex) {
              final movie = widget.movies[index];

              if (!isThin) {
                return _WideDeviceLayout(movie: movie);
              }

              return _ThinDeviceLayout(movie: movie);
            },
          ),
          const SizedBox(height: 8.0),
          Builder(builder: (context) {
            final colorScheme = Theme.of(context).colorScheme;

            return AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: widget.movies.length,
              duration: const Duration(milliseconds: 500),
              effect: WormEffect(
                dotColor: colorScheme.secondaryContainer,
                activeDotColor: colorScheme.onSecondaryContainer,
              ),
              onDotClicked: (index) => _controller.jumpToPage(index),
            );
          }),
        ],
      ),
    );
  }
}

VoidCallback _navigateToDetailPage(BuildContext context, int movieId) {
  return () => AppNavigator.movieDetail(context, movieId);
}

class _MovieExtrasText extends ConsumerWidget {
  const _MovieExtrasText({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieExtras = ref.watch(movieExtrasProvider);

    String language = movie.language;
    List<String> genreNames = [];

    if (movieExtras.languages.isNotEmpty) {
      language = movieExtras.languages.firstWhere((e) {
        return e.iso6391 == movie.language;
      }).englishName;
    }

    if (movieExtras.genres.isNotEmpty) {
      genreNames = movie.genreIds.map((id) {
        return movieExtras.genres.firstWhere((e) => e.id == id).name;
      }).toList();
    }

    return Opacity(
      opacity: 0.5,
      child: Text(
        [
          movie.releaseDate?.year ?? 'Coming Soon',
          language,
          genreNames.isEmpty ? 'Undefined' : genreNames.join(', '),
        ].join(' • '),
        key: _movieExtrasKey,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _ThinDeviceLayout extends StatelessWidget {
  const _ThinDeviceLayout({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _contentContainerKey,
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [
        DefaultNetworkImage(
          key: _imageKey,
          imageUrl: '$tmdbImageBaseUrl${movie.backdropPath}',
          imageBuilder: (context, imageProvider) {
            return Ink.image(
              image: imageProvider,
              fit: BoxFit.cover,
              child: InkWell(onTap: _navigateToDetailPage(context, movie.id)),
            );
          },
        ),
        _fader(),
        IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(builder: (context) {
              final textTheme = Theme.of(context).textTheme;

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    movie.title,
                    key: _movieTitleKey,
                    style: textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _MovieExtrasText(movie: movie),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _fader() {
    return IgnorePointer(
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.2),
              Colors.black,
            ],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: Builder(builder: (context) {
          return Container(color: Theme.of(context).scaffoldBackgroundColor);
        }),
      ),
    );
  }
}

class _WideDeviceLayout extends StatelessWidget {
  const _WideDeviceLayout({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      key: _contentContainerKey,
      child: InkWell(
        onTap: _navigateToDetailPage(context, movie.id),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0).copyWith(right: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      key: _movieTitleKey,
                      style: textTheme.headlineLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    _MovieExtrasText(movie: movie),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(movie.overview, key: _movieOverviewKey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SizedBox.expand(
                child: _faderMask(
                  child: DefaultNetworkImage(
                    key: _imageKey,
                    imageUrl: '$tmdbImageBaseUrl${movie.backdropPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _faderMask({Widget? child}) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.transparent, Colors.black87, Colors.black],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
