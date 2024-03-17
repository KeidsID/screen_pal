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

    return Consumer(builder: (context, ref, _) {
      final productsAsyncValue = ref.watch(provider);

      final products = productsAsyncValue.asData?.value ?? [];

      return ProductListSection(
        title: 'Recommendations',
        products: products,
        alt: productsAsyncValue.whenOrNull(
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

            return SizedExceptionWidget.expand(
              err,
              trace: trace,
              action: action,
            );
          },
        ),
      );
    });
  }
}
