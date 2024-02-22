part of '../product_detail_view.dart';

class _ExtrasSection extends ConsumerWidget {
  const _ExtrasSection(this.product);

  final ProductDetail product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // # TMDB server invalid data. <Des, 21th 2023: movie-572802-aquaman-and-the-lost-kingdom>.
    //
    // Movie detail [language] (in iso-639-1 form) and [languages]
    // (list of language object) properties are not synchronized.
    //
    // final languages = product.languages;

    final extras = (product is MovieDetail)
        ? ref.watch(movieExtrasProvider)
        : ref.watch(tvShowExtrasProvider);
    final languages = extras.languages;

    return Text(
      [
        product.releaseDate?.year ?? 'Coming Soon',
        languages
            .firstWhere(
              (e) => e.iso6391 == product.language,
              orElse: () => const SpokenLanguage(
                iso6391: 'xx',
                englishName: 'No Language',
                name: 'No Language',
              ),
            )
            .englishName,
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
