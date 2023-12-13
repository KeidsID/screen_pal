import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/remote/movies/movie_detail_provider.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/views/products/product_detail_view/product_detail_view.dart';

class MovieDetailView extends StatelessWidget {
  const MovieDetailView(this.movieId, {super.key});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, __) {
        final movieDetailProv = ref.watch(movieDetailProvider(movieId));

        final loadingWidget = RiverpodAsyncValueHandlers.loading();

        if (movieDetailProv.isRefreshing) return loadingWidget;

        return movieDetailProv.when(
          loading: () => loadingWidget,
          error: (error, stackTrace) => RiverpodAsyncValueHandlers.error(
            error,
            stackTrace,
            action: () => ref.invalidate(movieDetailProvider),
          ),
          data: (movie) => ProductDetailView(movie),
        );
      }),
    );
  }
}
