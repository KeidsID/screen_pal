import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/remote/tv_shows/tv_show_detail_provider.dart';
import 'package:screen_pal/interfaces/views/utils/product_detail_view/product_detail_view.dart';
import 'package:screen_pal/interfaces/widgets.dart';

class TvShowDetailView extends StatelessWidget {
  const TvShowDetailView(this.tvShowId, {super.key});

  final int tvShowId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, __) {
        final watchedProv = tvShowDetailProvider(tvShowId);
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
          data: (tvShow) => ProductDetailView(tvShow, isViewHasAppBar: true),
        );
      }),
    );
  }
}
