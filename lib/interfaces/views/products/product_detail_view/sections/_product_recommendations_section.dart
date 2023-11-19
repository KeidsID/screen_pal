part of '../product_detail_view.dart';

class _ProductRecommendationsSection extends StatelessWidget {
  const _ProductRecommendationsSection(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    late final AutoDisposeFutureProvider<List<Product>> provider;

    if (product is MovieDetail) {
      provider = movieRecommendationsProvider(product.id);
    } else {
      provider = tvShowRecommendationsProvider(product.id);
    }

    return ProductListSection(
      title: 'Recommendations',
      alt: 'No recommendations yet',
      autoDisposeProductsProvider: provider,
    );
  }
}
