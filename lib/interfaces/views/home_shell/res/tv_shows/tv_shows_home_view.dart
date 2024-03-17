import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/remote/tv_shows/tv_show_list_providers.dart';
import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

class TvShowsHomeView extends StatelessWidget {
  const TvShowsHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductsCarouselSection(popularTvShowsProvider),
              const SizedBox(height: 16.0),
              _TvShowsSection(
                title: 'Airing Today',
                provider: airingTodayTvShowsProvider,
              ),
              const SizedBox(height: 16.0),
              _TvShowsSection(
                title: 'On Air',
                provider: onAirTvShowsProvider,
              ),
              const SizedBox(height: 16.0),
              _TvShowsSection(
                title: 'Top Rated',
                provider: topRatedTvShowsProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TvShowsSection extends ConsumerWidget {
  const _TvShowsSection({
    required this.title,
    required this.provider,
  });

  final String title;
  final FutureProvider<List<TvShow>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tvShowsAsyncValue = ref.watch(provider);

    final products = tvShowsAsyncValue.asData?.value ?? [];

    return ProductListSection(
      title: title,
      products: products,
      alt: tvShowsAsyncValue.whenOrNull(
        skipLoadingOnRefresh: false,
        loading: () => const SizedCircularProgressIndicator.expand(),
        error: (err, trace) {
          final action = ElevatedButton.icon(
            onPressed: () => ref.refresh(provider),
            icon: const Icon(Icons.refresh_outlined),
            label: const Text('Refresh'),
          );

          if (err is DioException) {
            return SizedDioExceptionWidget.expand(err, action: action);
          }

          return SizedExceptionWidget.expand(err, trace: trace, action: action);
        },
      ),
    );
  }
}
