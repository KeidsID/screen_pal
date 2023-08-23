import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/router/navigate_paths.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';

const _thinDeviceH = 600.0;
const _wideDeviceH = 800.0;

class MoviesCarousel extends StatelessWidget {
  const MoviesCarousel({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final isThin = deviceSize.width < 800;

    final deviceH = deviceSize.height;

    const takenH = 0.65; // percentage taken

    const minH = _thinDeviceH * takenH;
    const maxH = _wideDeviceH * takenH;

    final height = deviceH < _thinDeviceH
        ? minH
        : deviceH >= _wideDeviceH
            ? maxH
            : deviceH * takenH;

    return Padding(
      padding: EdgeInsets.only(top: isThin ? 0.0 : 16.0),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: height,
          enlargeCenterPage: isThin ? false : true,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
          viewportFraction: isThin ? 1 : 0.95,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 6),
          autoPlayAnimationDuration: const Duration(seconds: 2),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index, realIndex) {
          final movie = movies[index];

          if (!isThin) return _WideLayout(movie: movie);

          return _ThinLayout(movie: movie);
        },
      ),
    );
  }
}

VoidCallback _navigateToDetailPage(BuildContext context, int movieId) {
  return () => context.go(NavigatePaths.moviesDetail(movieId));
}

class _ThinLayout extends StatelessWidget {
  const _ThinLayout({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: _navigateToDetailPage(context, movie.id),
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.expand,
        children: [
          DefaultNetworkImage(
            imageUrl: '$tmdbImageBaseUrl${movie.backdropPath}',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.scaffoldBackgroundColor,
                  theme.scaffoldBackgroundColor.withOpacity(0.1),
                  Colors.transparent
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  movie.title,
                  style: textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  [movie.releaseDate.year, '${movie.voteAverage * 10}%']
                      .join(' • '),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      child: InkWell(
        onTap: _navigateToDetailPage(context, movie.id),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0).copyWith(right: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textTheme.headlineLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      [movie.releaseDate.year, '${movie.voteAverage * 10}%']
                          .join(' • '),
                    ),
                    const SizedBox(height: 8.0),
                    Builder(builder: (context) {
                      final deviceH = MediaQuery.of(context).size.height;

                      final maxLines = deviceH >= _wideDeviceH
                          ? 16
                          : deviceH >= 750.0
                              ? 14
                              : deviceH >= 700.0
                                  ? 12
                                  : deviceH >= 650.0
                                      ? 10
                                      : 8;

                      return Text(
                        movie.overview,
                        textAlign: TextAlign.justify,
                        maxLines: maxLines,
                        overflow: TextOverflow.ellipsis,
                      );
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 600,
                child: SizedBox.expand(
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                          Colors.black,
                        ],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: DefaultNetworkImage(
                      imageUrl: '$tmdbImageBaseUrl${movie.backdropPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
