import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/remote/credits/products_credits.dart';
import 'package:screen_pal/interfaces/providers/remote/movies/movie_detail_provider.dart';
import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

class MovieCreditsView extends ConsumerWidget {
  const MovieCreditsView(this.movieId, {super.key});

  final int movieId;

  AutoDisposeFutureProvider<Credits> get _creditsProvider =>
      movieCreditsProvider(movieId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetailAsync = ref.watch(movieDetailProvider(movieId));
    final movieCreditsAsync = ref.watch(_creditsProvider);

    return Scaffold(
      appBar: movieDetailAsync.whenOrNull(
            skipLoadingOnRefresh: false,
            data: (movie) => AppBar(title: Text('"${movie.title}" Credits')),
          ) ??
          AppBar(),
      body: movieCreditsAsync.when(
        skipLoadingOnRefresh: false,
        loading: () => const SizedCircularProgressIndicator.expand(),

        //
        error: (err, trace) {
          final action = ElevatedButton.icon(
            onPressed: () => ref.refresh(_creditsProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          );

          if (err is DioException) {
            return SizedDioExceptionWidget.expand(err, action: action);
          }

          return SizedExceptionWidget.expand(err, trace: trace, action: action);
        },

        //
        data: (credits) => CreditsViewBody(credits),
      ),
    );
  }
}
