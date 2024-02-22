import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/remote/movies/movie_detail_provider.dart';
import 'package:screen_pal/interfaces/widgets.dart';

class MovieDetailView extends StatelessWidget {
  const MovieDetailView(this.movieId, {super.key});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, __) {
        final watchedProv = movieDetailProvider(movieId);
        final movieDetailProv = ref.watch(watchedProv);

        return movieDetailProv.when(
          skipLoadingOnRefresh: false,
          loading: () => const SizedCircularProgressIndicator.expand(),

          //
          error: (e, trace) {
            final action = ElevatedButton.icon(
              onPressed: () => ref.refresh(watchedProv),
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            );

            if (e is DioException) {
              if ((e.response?.statusCode ?? 0) == 404) {
                return SizedDioExceptionWidget.expand(e);
              }

              return SizedDioExceptionWidget.expand(e, action: action);
            }

            return SizedExceptionWidget.expand(e, trace: trace, action: action);
          },

          //
          data: (movie) => ProductDetailView(movie, isViewHasAppBar: true),
        );
      }),
    );
  }
}
