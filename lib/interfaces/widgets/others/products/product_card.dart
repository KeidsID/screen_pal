import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/interfaces/providers/remote/extras/extras_providers.dart';
import 'package:screen_pal/interfaces/router/routes.dart';
import 'package:screen_pal/interfaces/utils/m3_text_styles.dart';
import 'package:screen_pal/interfaces/widgets/common/common_network_image.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(this.product, {super.key});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isCardHovered = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isAdult = (product is Movie) ? product.isAdult : false;

    return Card(
      child: InkWell(
        onTap: _onCardTap,
        onHover: (isHovered) => setState(() => isCardHovered = isHovered),
        onLongPress: () {
          final scaffoldMessenger = ScaffoldMessenger.of(context);

          scaffoldMessenger.clearSnackBars();
          scaffoldMessenger.showSnackBar(_detailSnackBar());
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            CommonNetworkImage(
              imageUrl: '${product.posterImageUrl}',
              alt: product.title,
              fit: BoxFit.cover,
            ),
            isAdult ? const _AdultBanner() : const SizedBox(),
            isCardHovered ? _DetailOnHover(product) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  void _onCardTap() {
    final product = widget.product;

    if (product is Movie) {
      MovieDetailRoute(movieId: '${product.id}').go(context);
      return;
    }

    TvShowDetailRoute(tvShowId: '${product.id}').go(context);
  }

  SnackBar _detailSnackBar() {
    final movie = widget.product;

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(movie.title),
          _ExtrasText(
            movie,
            isShowReleaseDate: true,
            isShowMainGenreOnly: false,
          ),
        ],
      ),
    );
  }
}

class _AdultBanner extends StatelessWidget {
  const _AdultBanner();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Banner(
      message: 'ADULT',
      location: BannerLocation.topEnd,
      color: colorScheme.error,
      textStyle: DefaultTextStyle.of(context)
          .style
          .copyWith(color: colorScheme.onError),
    );
  }
}

class _DetailOnHover extends StatelessWidget {
  const _DetailOnHover(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor.withOpacity(0.6),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              product.title,
              style: M3TextStyles.titleMedium.toStyle(context),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              '${product.releaseDate?.year ?? 'Coming Soon'}',
            ),
          ),
          _ExtrasText(product),
        ],
      ),
    );
  }
}

class _ExtrasText extends ConsumerWidget {
  const _ExtrasText(
    this.product, {
    this.isShowReleaseDate = false,
    this.isShowMainGenreOnly = true,
  });

  final Product product;

  final bool isShowReleaseDate;
  final bool isShowMainGenreOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extras = (product is Movie)
        ? ref.watch(movieExtrasProvider)
        : ref.watch(tvShowExtrasProvider);

    String language = product.language;
    List<String> genreNames = [];

    if (extras.languages.isNotEmpty) {
      language = extras.languages.firstWhere((e) {
        return e.iso6391 == product.language;
      }).englishName;
    }

    if (extras.genres.isNotEmpty) {
      genreNames = product.genreIds.map((id) {
        return extras.genres.firstWhere((e) => e.id == id).name;
      }).toList();
    }

    return Text(
      [
        ...(isShowReleaseDate
            ? ['${product.releaseDate?.year ?? 'Coming Soon'}']
            : []),
        language,
        genreNames.isEmpty
            ? 'Undefined'
            : isShowMainGenreOnly
                ? genreNames[0]
                : genreNames.join(', '),
      ].join(' • '),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
