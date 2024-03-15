import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/remote/credits/products_credits.dart';
import 'package:screen_pal/interfaces/providers/remote/tv_shows/tv_show_detail_provider.dart';
import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

class TvShowCreditsView extends ConsumerWidget {
  const TvShowCreditsView(this.tvShowId, {super.key});

  final int tvShowId;

  AutoDisposeFutureProvider<TvCredits> get _creditsProvider =>
      tvShowFullCreditsProvider(tvShowId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tvShowDetailAsync = ref.watch(tvShowDetailProvider(tvShowId));
    final tvShowFullCreditsAsync = ref.watch(_creditsProvider);

    return Scaffold(
      appBar: tvShowDetailAsync.whenOrNull(
            skipLoadingOnRefresh: false,
            data: (tvShow) => AppBar(title: Text('"${tvShow.title}" Credits')),
          ) ??
          AppBar(),
      body: tvShowFullCreditsAsync.when(
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
