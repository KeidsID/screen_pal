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
          Text(
            'Last Season',
            style: kSectionTitleStyle(context),
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
    return SizedBox(
      width: 900.0,
      height: 320.0,
      child: Card(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return (constraints.maxWidth > 600.0)
                ? _wideLayout()
                : _thinLayout(context);
          },
        ),
      ),
    );
  }

  Widget _wideLayout() {
    return Row(
      children: [
        AspectRatio(
          aspectRatio: kAspectRatio(),
          child: CommonNetworkImage(
            imageUrl: '${season.posterImageUrl}',
            fit: BoxFit.cover,
          ),
        ),
        const VerticalDivider(width: 2.0, thickness: 2.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 16.0),
            child: _contents(),
          ),
        )
      ],
    );
  }

  Widget _thinLayout(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // bg image
        SizedBox(
          child: CommonNetworkImage(
            imageUrl: '${season.posterImageUrl}',
            repeat: ImageRepeat.repeatX,
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(color: Theme.of(context).cardColor.withOpacity(0.9)),

        // contents
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _contents(),
        )
      ],
    );
  }

  Widget _contents() {
    final overview =
        (season.overview.isNotEmpty) ? season.overview : 'No overview';

    final seasonOrder = season.seasonNumber.toOrdinal();
    final episodeOrder = episode.episodeNumber.toOrdinal();
    final episodeType = episode.episodeType;

    return Builder(
      builder: (context) {
        final textTheme = context.textTheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              season.name,
              style: textTheme.titleLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text('# $seasonOrder Season').applyOpacity(opacity: 0.5),
            const Divider(),

            //
            Expanded(
              child: SingleChildScrollView(
                child: Text(overview),
              ),
            ),
            const Divider(),

            //
            Text('Last Episode', style: textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('# $episodeOrder Episode').applyOpacity(opacity: 0.5),
                  ],
                ),
                (episodeType != 'finale')
                    ? const SizedBox()
                    : Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Season Finale',
                            style: textTheme.labelMedium,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        );
      },
    );
  }
}
