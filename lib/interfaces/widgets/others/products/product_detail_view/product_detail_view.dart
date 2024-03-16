import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:fl_utilities/fl_utilities.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/interfaces/providers/remote/credits/products_credits.dart';
import 'package:screen_pal/interfaces/providers/remote/extras/extras_providers.dart';
import 'package:screen_pal/interfaces/providers/remote/movies/movie_list_providers.dart';
import 'package:screen_pal/interfaces/providers/remote/tv_shows/tv_show_list_providers.dart';
import 'package:screen_pal/interfaces/router/routes.dart';
import 'package:screen_pal/interfaces/utils.dart';
import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

part 'sections/_credits_section.dart';
part 'sections/_extras_section.dart';
part 'sections/_movie_collection_section.dart';
part 'sections/_product_recommendations_section.dart';
part 'sections/_tv_show_season_section.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView(
    this.product, {
    super.key,
    this.isViewHasAppBar = false,
  });

  final ProductDetail product;
  final bool isViewHasAppBar;

  @override
  Widget build(BuildContext context) {
    return CommonDetailViewLayout(
      delegate: CommonDetailViewLayoutDelegate(
        isViewHasAppBar: isViewHasAppBar,
        posterImageUrl: product.posterImageUrl,
        backdropImageUrl: product.backdropImageUrl,
        title: product.title,
        subtitle: _ExtrasSection(product),
        tagline: product.tagline,
        overview: product.overview,
        extras: _productStats(product),
      ),
      children: [
        _CreditsSection(product),
        _MovieCollectionSection(product),
        _TvShowSeasonSection(product),
        _ProductRecommendationsSection(product),
      ],
    );
  }

  List<String> _productStats(ProductDetail product) {
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

    return contents;
  }
}
