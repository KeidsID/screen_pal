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
        Padding(
          padding: kHorizPadding,
          child: Text(
            'Casts',
            style: M3TextStyles.headlineMedium.toStyle(context),
          ),
        ),
        Consumer(builder: (context, ref, child) {
          final creditsAsync = ref.watch(provider);

          const maxH = 270.0;

          return creditsAsync.when(
            skipLoadingOnRefresh: false,
            loading: () => const SizedCircularProgressIndicator(height: maxH),

            //
            error: (e, trace) {
              if (e is DioException) {
                return SizedDioExceptionWidget(e, height: maxH);
              }

              return SizedExceptionWidget(e, trace: trace, height: maxH);
            },

            //
            data: (credits) {
              final casts = credits.casts;

              if (casts.isEmpty) {
                return SizedBox(
                  height: maxH,
                  child: Center(
                    child: Text(
                      'No special cast',
                      style: M3TextStyles.titleMedium.toStyle(context),
                    ),
                  ),
                );
              }

              const maxCasts = 10;
              final filteredCasts =
                  casts.length > maxCasts ? casts.sublist(0, maxCasts) : casts;

              return PersonsHorizListView(
                filteredCasts,
                trailing: Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('View More'),
                        SizedBox(width: 8.0),
                        Icon(Icons.arrow_right_alt)
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
        const SizedBox(height: 8.0),
        Padding(
          padding: kHorizPadding,
          child: TextButton(
            onPressed: () {},
            child: const Text('Full Cast & Crew'),
          ),
        ),
        const Padding(padding: kHorizPadding, child: Divider()),
      ],
    );
  }
}
