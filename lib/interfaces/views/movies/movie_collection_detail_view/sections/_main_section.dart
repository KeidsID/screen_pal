part of '../movie_collection_detail_view.dart';

class _MainSection extends StatelessWidget {
  const _MainSection(
    this.movieCollection, {
    this.isWideLayout = false,
    this.padding = kHorizPadding,
  });

  final MovieCollectionDetail movieCollection;
  final bool isWideLayout;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialText(movieCollection.name, style: M3TextStyles.headlineLarge),
          _CollectionGenresText(movieCollection),
          const SizedBox(height: 8.0),
          isWideLayout
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Text(movieCollection.overview),
                  ),
                )
              : Text(movieCollection.overview),
          const Divider(),
          MaterialText(
            'Movie count: ${movieCollection.parts.length}',
            style: M3TextStyles.titleSmall,
            opacity: 0.75,
          ),
        ],
      ),
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

    return MaterialText(
      genreNames.isEmpty ? 'Undefined' : genreNames.join(', '),
      opacity: 0.5,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
