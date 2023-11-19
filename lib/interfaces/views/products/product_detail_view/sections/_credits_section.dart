part of '../product_detail_view.dart';

class _CreditsSection extends StatelessWidget {
  final ProductDetail product;

  const _CreditsSection(this.product);

  @override
  Widget build(BuildContext context) {
    late final AutoDisposeFutureProvider<Credits> provider;

    if (product is MovieDetail) {
      provider = movieCreditsProvider(product.id);
    } else {
      provider = tvShowCreditsProvider(product.id);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: kHorizPadding,
          child: MaterialText(
            'Casts',
            style: M3TextStyles.headlineMedium,
          ),
        ),
        Consumer(builder: (context, ref, child) {
          final creditsAsync = ref.watch(provider);

          final loadingWidget = RiverpodAsyncValueHandlers.loading();
          const placeholderHeight = 270.0;

          if (creditsAsync.isRefreshing) return loadingWidget;

          return creditsAsync.when(
            loading: () => SizedBox(
              height: placeholderHeight,
              child: loadingWidget,
            ),
            error: (err, stack) => SizedBox(
              height: placeholderHeight,
              child: RiverpodAsyncValueHandlers.error(err, stack),
            ),
            data: (credits) {
              final casts = credits.casts;

              if (casts.isEmpty) {
                return const SizedBox(
                  height: placeholderHeight,
                  child: Center(
                    child: MaterialText(
                      'No special cast',
                      style: M3TextStyles.titleMedium,
                    ),
                  ),
                );
              }

              return PersonsHorizListView(casts);
            },
          );
        }),
        const Padding(padding: kHorizPadding, child: Divider()),
      ],
    );
  }
}
