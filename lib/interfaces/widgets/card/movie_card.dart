import 'package:flutter/material.dart';

import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/router/app_navigator.dart';
import 'package:screen_pal/interfaces/widgets/card/ink_well_card.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

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

    return InkWellCard(
      onTap: () => AppNavigator.moviesDetail(context, movie.id),
      onHover: (isHovered) => setState(() => isCardHovered = isHovered),
      // onLongPress: ,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DefaultNetworkImage(
            imageUrl: '$tmdbImageBaseUrl${movie.posterPath}',
            fit: BoxFit.cover,
          ),
          movie.adult
              ? const Banner(
                  message: '18+',
                  location: BannerLocation.topEnd,
                  color: Colors.red,
                )
              : const SizedBox(),
          isCardHovered
              ? Container(
                  color: theme.cardColor.withOpacity(0.75),
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
                      Text('${movie.releaseDate.year}'),
                      Text('${movie.voteAverage * 10}%')
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
