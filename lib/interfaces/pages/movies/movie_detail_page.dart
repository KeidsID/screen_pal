import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_pal/common/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/providers/movies/movie_detail_provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (_, ref, __) {
        final movieDetailProv = ref.watch(movieDetailProvider(movieId));

        return movieDetailProv.when(
          loading: RiverpodAsyncValueHandlers.loading,
          error: RiverpodAsyncValueHandlers.error,
          data: (movieDetail) {
            return const SizedBox();
          },
        );
      }),
    );
  }
}
