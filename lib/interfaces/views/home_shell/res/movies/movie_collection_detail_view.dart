import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/interfaces/providers/remote/extras/genres_providers.dart';
import 'package:screen_pal/interfaces/providers/remote/movies/movie_collection_detail_provider.dart';
import 'package:screen_pal/interfaces/widgets.dart';

class MovieCollectionDetailView extends StatelessWidget {
  const MovieCollectionDetailView(this.collectionId, {super.key});

  final int collectionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, __) {
        final watchedProv = movieCollectionDetailProvider(collectionId);
        final movieCollectionDetailProv = ref.watch(watchedProv);

        return movieCollectionDetailProv.when(
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
              return SizedDioExceptionWidget.expand(e, action: action);
            }

            return SizedExceptionWidget.expand(e, trace: trace, action: action);
          },

          //
          data: (data) {
            return CommonDetailViewLayout(
              delegate: CommonDetailViewLayoutDelegate(
                isViewHasAppBar: true,
                posterImageUrl: data.posterImageUrl,
                backdropImageUrl: data.backdropImageUrl,
                title: data.name,
                subtitle: _CollectionGenresText(data),
                overview: data.overview,
                extras: ['Movie count: ${data.parts.length}'],
              ),
              children: [
                ProductListSection(
                  title: 'Movies',
                  products: data.parts,
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

class _CollectionGenresText extends ConsumerWidget {
  const _CollectionGenresText(this.movieCollectionDetail);

  final MovieCollectionDetail movieCollectionDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(movieGenresProvider);

    List<String> genreNames = [];

    if (genres.isNotEmpty) {
      final List<List<int>> genreIdsList = movieCollectionDetail.parts.map((e) {
        return e.genreIds;
      }).toList();

      final List<int> collectionGenreIds =
          genreIdsList.expand((e) => e).toSet().toList();

      genreNames = collectionGenreIds.map((id) {
        return genres.firstWhere((e) => e.id == id).name;
      }).toList();
    }

    return Text(
      genreNames.isEmpty ? 'Undefined' : genreNames.join(', '),
      style: M3TextStyles.bodyMedium.toStyle(context, opacity: 0.5),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
