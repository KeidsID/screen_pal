import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/tv_shows/tv_show_detail_provider.dart';
import 'package:screen_pal/interfaces/utils/riverpod_async_value_handlers.dart';
import 'package:screen_pal/interfaces/views/products/product_detail_view/product_detail_view.dart';

class TvShowDetailView extends StatelessWidget {
  const TvShowDetailView(this.tvShowId, {super.key});

  final int tvShowId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, __) {
        final movieDetailProv = ref.watch(tvShowDetailProvider(tvShowId));

        final loadingWidget = RiverpodAsyncValueHandlers.loading();

        if (movieDetailProv.isRefreshing) return loadingWidget;

        return movieDetailProv.when(
          loading: () => loadingWidget,
          error: (error, stackTrace) => RiverpodAsyncValueHandlers.error(
            error,
            stackTrace,
            action: () => ref.invalidate(tvShowDetailProvider),
          ),
          data: (tvShow) => ProductDetailView(tvShow),
        );
      }),
    );
  }
}
