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
          _LastSeasonCard(season: lastSeason, episode: lastEpisode),
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
    return Card(
      child: MaterialText(season.name),
    );
  }
}
