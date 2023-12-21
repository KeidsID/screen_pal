import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/entities/products/product.dart';
import 'package:screen_pal/interfaces/providers/remote/extras/extras_providers.dart';
import 'package:screen_pal/interfaces/router/routes.dart';
import 'package:screen_pal/interfaces/widgets/common/common_network_image.dart';
import 'package:screen_pal/interfaces/utils/m3_text_styles.dart';

// Tests Utils:

/// To check which layout are rendered.
const _contentContainerKey = Key('content-container');

// To check product contents:

const _imageKey = Key('image-widget');
const _productTitleKey = Key('product-title');
const _productExtrasKey = Key('product-extras');
const _productOverviewKey = Key('product-overview');

class ProductsCarousel extends StatefulWidget {
  /// Create a Carousel widget that displays basic information of the
  /// movies/tv-shows provided.
  ///
  /// Max number of product are 10. To make sure the indicator not overflow
  /// from the screen.
  const ProductsCarousel(
    this.products, {
    super.key,
    this.height = 600.0,
    this.enableInfiniteScroll = true,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
  }) : assert(products.length <= 10);

  final List<Product> products;

  /// Widget height.
  final double height;

  /// Determines if carousel should loop infinitely or be limited to item length.
  ///
  /// Defaults to true, i.e. infinite loop.
  final bool enableInfiniteScroll;

  /// Enables auto play, sliding one page at a time.
  ///
  /// Use [autoPlayInterval] to determent the frequency of slides. Defaults to false.
  final bool autoPlay;

  /// Sets Duration to determent the frequency of slides when
  ///
  /// [autoPlay] is set to true.
  /// Defaults to 4 seconds.
  final Duration autoPlayInterval;

  /// The animation duration between two transitioning pages while in auto playback.
  ///
  /// Defaults to 800 ms.
  final Duration autoPlayAnimationDuration;

  @override
  State<ProductsCarousel> createState() => _ProductsCarouselState();
}

class _ProductsCarouselState extends State<ProductsCarousel> {
  /// Carousel current index
  int currentIndex = 0;

  final _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final maxW = deviceSize.width;
    final maxH = widget.height;

    final aspectRatio = deviceSize.aspectRatio;
    final isWide =
        (maxW >= 1000) ? (aspectRatio >= kAspectRatio() && maxW > maxH) : false;

    return Container(
      width: maxW,
      height: isWide ? maxH : maxH * 20.0,
      padding: EdgeInsets.only(top: isWide ? 16.0 : 0.0),
      child: Column(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: CarouselSlider.builder(
                carouselController: _controller,
                options: CarouselOptions(
                  enableInfiniteScroll: widget.enableInfiniteScroll,
                  aspectRatio: kAspectRatio(isPotrait: !isWide),
                  enlargeCenterPage: isWide,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  viewportFraction: isWide ? 0.9 : 1,
                  autoPlay: widget.autoPlay,
                  autoPlayInterval: widget.autoPlayInterval,
                  autoPlayAnimationDuration: widget.autoPlayAnimationDuration,
                  onPageChanged: (index, _) =>
                      setState(() => currentIndex = index),
                ),
                itemCount: widget.products.length,
                itemBuilder: (context, index, realIndex) {
                  final product = widget.products[index];

                  if (isWide) {
                    return _WideDeviceLayout(
                      product,
                      key: _contentContainerKey,
                    );
                  }

                  return _ThinDeviceLayout(product, key: _contentContainerKey);
                },
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Builder(builder: (context) {
            final colorScheme = Theme.of(context).colorScheme;

            return AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: widget.products.length,
              duration: const Duration(milliseconds: 500),
              effect: WormEffect(
                dotColor: colorScheme.secondaryContainer,
                activeDotColor: colorScheme.onSecondaryContainer,
              ),
              onDotClicked: (index) => _controller.jumpToPage(index),
            );
          }),
        ],
      ),
    );
  }
}

VoidCallback _onItemTap(BuildContext context, Product product) {
  return () => (product is Movie)
      ? MovieDetailRoute(movieId: '${product.id}').go(context)
      : TvShowDetailRoute(tvShowId: '${product.id}').go(context);
}

class _ExtrasText extends ConsumerWidget {
  const _ExtrasText({required this.product});

  final Product product;

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
        product.releaseDate?.year ?? 'Coming Soon',
        language,
        genreNames.isEmpty ? 'Undefined' : genreNames.join(', '),
      ].join(' • '),
      key: _productExtrasKey,
      style: M3TextStyles.bodyMedium.toStyle(context, opacity: 0.5),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ThinDeviceLayout extends StatelessWidget {
  const _ThinDeviceLayout(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: key,
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [
        // image
        InkWell(
          onTap: _onItemTap(context, product),
          child: CommonNetworkImage(
            key: _imageKey,
            imageUrl: '${product.backdropImageUrl}',
            fit: BoxFit.cover,
          ),
        ),
        _fader(),

        // detail
        IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  product.title,
                  key: _productTitleKey,
                  style: M3TextStyles.headlineLarge.toStyle(context),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                _ExtrasText(product: product),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _fader() {
    return IgnorePointer(
      child: Builder(builder: (context) {
        final color = Theme.of(context).scaffoldBackgroundColor;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                color.withOpacity(0.2),
                color,
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _WideDeviceLayout extends StatelessWidget {
  const _WideDeviceLayout(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      child: InkWell(
        onTap: _onItemTap(context, product),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0).copyWith(right: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      key: _productTitleKey,
                      style: M3TextStyles.headlineLarge.toStyle(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    _ExtrasText(product: product),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(product.overview, key: _productOverviewKey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VerticalDivider(width: 2.0, thickness: 2.0),
            AspectRatio(
              aspectRatio: kAspectRatio(isPotrait: false),
              child: CommonNetworkImage(
                key: _imageKey,
                imageUrl: '${product.backdropImageUrl}',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
