import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_pal/core/entities/products/product.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/extras/extras_providers.dart';
import 'package:screen_pal/interfaces/router/app_navigator.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';

// Tests Utils:

/// To check which layout are rendered.
const _contentContainerKey = Key('content-container');

// To check product contents:

const _imageKey = Key('image-widget');
const _productTitleKey = Key('product-title');
const _productExtrasKey = Key('product-extras');
const _productOverviewKey = Key('product-overview');

class ProductsCarousel extends ConsumerStatefulWidget {
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
  ConsumerState<ProductsCarousel> createState() => _ProductsCarouselState();
}

class _ProductsCarouselState extends ConsumerState<ProductsCarousel> {
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
        (maxW >= 600) ? (aspectRatio >= 3 / 2 && maxW > maxH) : false;

    return Container(
      width: maxW,
      height: maxH,
      padding: EdgeInsets.only(top: isWide ? 16.0 : 0.0),
      child: Column(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: CarouselSlider.builder(
                carouselController: _controller,
                options: CarouselOptions(
                  enableInfiniteScroll: widget.enableInfiniteScroll,
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

                  if (isWide) return _WideDeviceLayout(product: product);

                  return _ThinDeviceLayout(product: product);
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
      ? AppNavigator.movieDetail(context, product.id)
      : AppNavigator.tvShowDetail(context, product.id);
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

    return Opacity(
      opacity: 0.5,
      child: Text(
        [
          product.releaseDate?.year ?? 'Coming Soon',
          language,
          genreNames.isEmpty ? 'Undefined' : genreNames.join(', '),
        ].join(' • '),
        key: _productExtrasKey,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _ThinDeviceLayout extends StatelessWidget {
  const _ThinDeviceLayout({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      key: _contentContainerKey,
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [
        DefaultNetworkImage(
          key: _imageKey,
          imageUrl: '$tmdbImageBaseUrl${product.backdropPath}',
          imageBuilder: (context, imageProvider) {
            return Ink.image(
              image: imageProvider,
              fit: BoxFit.cover,
              child: InkWell(onTap: _onItemTap(context, product)),
            );
          },
        ),
        _fader(),
        IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  product.title,
                  key: _productTitleKey,
                  style: textTheme.headlineLarge,
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
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.2),
              Colors.black,
            ],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: Builder(builder: (context) {
          return Container(color: Theme.of(context).scaffoldBackgroundColor);
        }),
      ),
    );
  }
}

class _WideDeviceLayout extends StatelessWidget {
  const _WideDeviceLayout({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      key: _contentContainerKey,
      child: InkWell(
        onTap: _onItemTap(context, product),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0).copyWith(right: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      key: _productTitleKey,
                      style: textTheme.headlineLarge,
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
            Expanded(
              flex: 6,
              child: SizedBox.expand(
                child: _faderMask(
                  child: DefaultNetworkImage(
                    key: _imageKey,
                    imageUrl: '$tmdbImageBaseUrl${product.backdropPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _faderMask({Widget? child}) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.transparent, Colors.black87, Colors.black],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
