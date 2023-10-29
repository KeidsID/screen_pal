part of '../product_detail_view.dart';

class _MainSection extends StatelessWidget {
  const _MainSection(
    this.product, {
    this.isWideLayout = false,
    this.padding = kHorizPadding,
  });

  final ProductDetail product;
  final bool isWideLayout;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialText(product.title, style: M3TextStyles.headlineLarge),
          _ProductDetailExtrasText(product),
          product.tagline.isEmpty
              ? const SizedBox()
              : MaterialText('# ${product.tagline}', opacity: 0.5),
          const SizedBox(height: 8.0),
          isWideLayout
              ? Expanded(
                  child: SingleChildScrollView(child: Text(product.overview)))
              : Text(product.overview),
          const Divider(),
          ...statsDetail(product),
        ],
      ),
    );
  }

  List<MaterialText> statsDetail(ProductDetail product) {
    late List<String> contents;

    if (product is MovieDetail) {
      final budget = (product.budget <= 0)
          ? 'No Data'
          : NumberFormat.currency(symbol: r'$').format(product.budget);
      final revenue = (product.revenue <= 0)
          ? 'No Data'
          : NumberFormat.currency(symbol: r'$').format(product.revenue);

      contents = [
        'Status: ${product.status}',
        'Budget: $budget',
        'Revenue: $revenue',
      ];
    } else if (product is TvShowDetail) {
      final nextAirDate = (product.nextEpisodeToAir?.airDate == null)
          ? 'No Data'
          : DateFormat.yMMMd().format(product.nextEpisodeToAir!.airDate!);

      contents = [
        'Status: ${product.status}',
        'Season count: ${product.seasonCount}',
        'Next air date: $nextAirDate'
      ];
    }

    return contents.map((text) {
      return MaterialText(text, style: M3TextStyles.titleSmall, opacity: 0.75);
    }).toList();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(kIsVisibleFlagProperty(true));
  }
}

class _ProductDetailExtrasText extends StatelessWidget {
  const _ProductDetailExtrasText(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final languages = product.languages;

    return MaterialText(
      [
        product.releaseDate?.year ?? 'Coming Soon',
        languages.firstWhere((e) => e.iso6391 == product.language).englishName,
        product.genres.isEmpty
            ? 'Undefined'
            : product.genres.map((e) => e.name).join(', ')
      ].join(' • '),
      opacity: 0.5,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
