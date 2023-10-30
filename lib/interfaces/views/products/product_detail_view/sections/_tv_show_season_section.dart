part of '../product_detail_view.dart';

class _TvShowSeasonSection extends StatelessWidget {
  const _TvShowSeasonSection(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    if (!_checkLastSeason(product)) return const SizedBox();

    final tvShow = (product as TvShowDetail);

    /// /// Won't null, already checkked on [_checkLastSeason] method.
    final lastEpisode = tvShow.lastEpisodeToAir!;
    final lastSeason = tvShow.seasons
        .where((e) => e.seasonNumber == lastEpisode.seasonNumber)
        .first;

    return Padding(
      padding: kHorizPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MaterialText(
            'Last Season',
            style: kSectionTitleStyle,
          ),
          Align(
            alignment: Alignment.center,
            child: _LastSeasonCard(season: lastSeason, episode: lastEpisode),
          ),
          const Divider(),
        ],
      ),
    );
  }

  /// return true if [product] contain a last season.
  bool _checkLastSeason(ProductDetail product) {
    if (product is! TvShowDetail) return false;

    final lastEpisode = product.lastEpisodeToAir;
    final lastSeason = product.seasons
        .where((e) => e.seasonNumber == lastEpisode?.seasonNumber)
        .firstOrNull;

    return (lastSeason != null);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(kIsVisibleFlagProperty(_checkLastSeason(product)));
  }
}

class _LastSeasonCard extends StatelessWidget {
  const _LastSeasonCard({required this.season, required this.episode});

  final Season season;
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final overview =
        (season.overview.isNotEmpty) ? season.overview : 'No overview';

    final seasonOrder = season.seasonNumber.toOrdinal();
    final episodeOrder = episode.episodeNumber.toOrdinal();
    final episodeType = episode.episodeType;

    return SizedBox(
      width: 800.0,
      height: 320.0,
      child: Card(
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: DefaultNetworkImage(
                imageUrl: '$tmdbImageBaseUrl${season.posterPath}',
                alt: '${season.seasonNumber} Season-${season.name}',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialText(
                      season.name,
                      style: M3TextStyles.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    MaterialText('# $seasonOrder Season', opacity: 0.5),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: MaterialText(overview),
                      ),
                    ),
                    const Divider(),
                    const MaterialText(
                      'Last Episode',
                      style: M3TextStyles.titleMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialText(
                              episode.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            MaterialText('# $episodeOrder Episode',
                                opacity: 0.5),
                          ],
                        ),
                        (episodeType != 'finale')
                            ? const SizedBox()
                            : const Card(
                                elevation: 3.0,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: MaterialText(
                                    'Season Finale',
                                    style: M3TextStyles.labelMedium,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
