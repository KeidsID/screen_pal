import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/extras/extras_providers.dart';
import 'package:screen_pal/interfaces/router/app_navigator.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isCardHovered = false;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      child: InkWell(
        onTap: () => AppNavigator.movieDetail(context, movie.id),
        onHover: (isHovered) => setState(() => isCardHovered = isHovered),
        onLongPress: () {
          final scaffoldMessenger = ScaffoldMessenger.of(context);

          scaffoldMessenger.clearSnackBars();
          scaffoldMessenger.showSnackBar(_detailSnackBar());
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            DefaultNetworkImage(
              imageUrl: '$tmdbImageBaseUrl${movie.posterPath}',
              alt: movie.title,
              imageBuilder: (_, imgProvider) => Ink.image(
                image: imgProvider,
                fit: BoxFit.cover,
              ),
            ),
            movie.isAdult
                ? Banner(
                    message: 'ADULT',
                    location: BannerLocation.topEnd,
                    color: theme.colorScheme.error,
                    textStyle: textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onError,
                    ),
                  )
                : const SizedBox(),
            isCardHovered
                ? Container(
                    color: theme.cardColor.withOpacity(0.6),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          movie.title,
                          style: textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text('${movie.releaseDate?.year ?? 'Coming Soon'}'),
                        Consumer(builder: (_, ref, __) {
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
                              return movieExtras.genres
                                  .firstWhere((e) => e.id == id)
                                  .name;
                            }).toList();
                          }

                          return Text(
                            [
                              language,
                              genreNames.isEmpty ? 'Undefined' : genreNames[0],
                            ].join(' • '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        })
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  SnackBar _detailSnackBar() {
    final movie = widget.movie;

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(movie.title),
          Consumer(builder: (_, ref, __) {
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

            return Text(
              [
                '${movie.releaseDate?.year ?? 'Coming Soon'}',
                language,
                genreNames.isEmpty ? 'Undefined' : genreNames[0],
              ].join(' • '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          }),
        ],
      ),
    );
  }
}
