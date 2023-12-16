part of '../product_detail_view.dart';

class _ExtrasSection extends StatelessWidget {
  const _ExtrasSection(this.product);

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
