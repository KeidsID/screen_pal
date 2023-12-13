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
          Text(
            product.title,
            style: M3TextStyles.headlineLarge.toStyle(context),
          ),
          _ProductDetailExtrasText(product),
          product.tagline.isEmpty
              ? const SizedBox()
              : Text(
                  '# ${product.tagline}',
                  style: M3TextStyles.bodyMedium.toStyle(context, opacity: 0.5),
                ),
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

  List<Widget> statsDetail(ProductDetail product) {
    late final List<String> contents;

    if (product is MovieDetail) {
      final budget = (product.budget <= 0)
          ? 'No Data'
          : intl.NumberFormat.currency(symbol: r'$').format(product.budget);
      final revenue = (product.revenue <= 0)
          ? 'No Data'
          : intl.NumberFormat.currency(symbol: r'$').format(product.revenue);

      contents = [
        'Status: ${product.status}',
        'Budget: $budget',
        'Revenue: $revenue',
      ];
    } else if (product is TvShowDetail) {
      final nextAirDate = (product.nextEpisodeToAir?.airDate == null)
          ? 'No Data'
          : intl.DateFormat.yMMMd().format(product.nextEpisodeToAir!.airDate!);

      contents = [
        'Status: ${product.status}',
        'Season count: ${product.seasonCount}',
        'Next air date: $nextAirDate'
      ];
    }

    return contents.map((text) {
      return Builder(builder: (context) {
        return Text(
          text,
          style: M3TextStyles.titleSmall.toStyle(context, opacity: 0.75),
        );
      });
    }).toList();
  }
}

class _ProductDetailExtrasText extends StatelessWidget {
  const _ProductDetailExtrasText(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final languages = product.languages;

    return Text(
      [
        product.releaseDate?.year ?? 'Coming Soon',
        languages.firstWhere((e) => e.iso6391 == product.language).englishName,
        product.genres.isEmpty
            ? 'Undefined'
            : product.genres.map((e) => e.name).join(', ')
      ].join(' • '),
      style: M3TextStyles.bodyMedium.toStyle(context, opacity: 0.5),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
