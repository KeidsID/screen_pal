import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_pal/common/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_detail_provider.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (_, ref, __) {
        final movieDetailProv = ref.watch(movieDetailProvider(movieId));

        if (movieDetailProv.isRefreshing) {
          return RiverpodAsyncValueHandlers.loading();
        }

        return movieDetailProv.when(
          loading: RiverpodAsyncValueHandlers.loading,
          error: (error, stackTrace) => RiverpodAsyncValueHandlers.error(
            error,
            stackTrace,
            action: () => ref.invalidate(movieDetailProvider),
          ),
          data: (movieDetail) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  DefaultNetworkImage(
                    imageUrl: '$tmdbImageBaseUrl${movieDetail.backdropPath}',
                    alt: movieDetail.title,
                    fit: BoxFit.cover,
                  ),
                  Text(movieDetail.title),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
