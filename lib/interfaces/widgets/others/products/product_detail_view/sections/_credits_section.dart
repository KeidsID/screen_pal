part of '../product_detail_view.dart';

class _CreditsSection extends StatelessWidget {
  final ProductDetail product;

  const _CreditsSection(this.product);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    late final AutoDisposeFutureProvider<Credits> creditsProvider;

    if (product is MovieDetail) {
      creditsProvider = movieCreditsProvider(product.id);
    } else {
      creditsProvider = tvShowCreditsProvider(product.id);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: kHorizPadding,
          child: Text('Casts', style: textTheme.headlineMedium),
        ),
        Consumer(builder: (context, ref, child) {
          final creditsAsync = ref.watch(creditsProvider);

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
                      'No cast data for now',
                      style: textTheme.titleMedium,
                    ),
                  ),
                );
              }

              const maxCasts = 10;
              final isMaxxed = casts.length > maxCasts;
              final filteredCasts =
                  isMaxxed ? casts.sublist(0, maxCasts) : casts;

              return CreditPersonsHorizListView(
                filteredCasts,
                trailing: isMaxxed
                    ? Center(
                        child: TextButton(
                          onPressed: () => _navToProductCredits(context),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('View more'),
                              SizedBox(width: 8.0),
                              Icon(Icons.arrow_right_alt)
                            ],
                          ),
                        ),
                      )
                    : null,
              );
            },
          );
        }),
        const SizedBox(height: 8.0),
        Padding(
          padding: kHorizPadding,
          child: TextButton(
            onPressed: () => _navToProductCredits(context),
            child: const Text('Full Cast & Crew'),
          ),
        ),
        const Padding(padding: kHorizPadding, child: Divider()),
      ],
    );
  }

  void _navToProductCredits(BuildContext context) {
    if (product is MovieDetail) {
      MovieCreditsRoute(movieId: '${product.id}').go(context);

      return;
    }

    TvShowCreditsRoute(tvShowId: '${product.id}').go(context);
  }
}
