part of '../product_detail_view.dart';

class _MovieCollectionSection extends StatelessWidget {
  const _MovieCollectionSection(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    if (!_checkCollection(product)) return const SizedBox();

    /// Won't null, already checkked on [_checkCollection] method.
    final movieCollection = (product as MovieDetail).movieCollection!;

    return Padding(
      padding: kHorizPadding,
      child: Column(
        children: [
          Center(child: _MovieCollectionCard(movieCollection)),
          const Divider()
        ],
      ),
    );
  }

  /// return true if [product] contain a movie collection.
  bool _checkCollection(ProductDetail product) {
    if (product is! MovieDetail) return false;

    return (product.movieCollection != null);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(kIsVisibleFlagProperty(_checkCollection(product)));
  }
}

class _MovieCollectionCard extends StatelessWidget {
  const _MovieCollectionCard(this.movieCollection);

  final MovieCollection movieCollection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600.0,
      height: 240.0,
      child: Card(
        child: InkWell(
          onTap: () =>
              AppNavigator.movieCollection(context, movieCollection.id),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DefaultNetworkImage(
                imageUrl: '$tmdbImageBaseUrl${movieCollection.backdropPath}',
                imageBuilder: (_, imgProvider) => Ink.image(
                  image: imgProvider,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.25),
                    BlendMode.modulate,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialText(
                      'Part of ${movieCollection.name}',
                      style: M3TextStyles.headlineSmall,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
