import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/interfaces/widgets.dart';

/// {@template interfaces.widgets.common.common_detail_view_layout}
/// Responsive widget for common detail view that didn't deppend on entity.
///
/// Typically used on [Scaffold.body] to make sure theme is applied.
/// {@endtemplate}
class CommonDetailViewLayout extends StatelessWidget {
  /// {@macro interfaces.widgets.common.common_detail_view_layout}
  const CommonDetailViewLayout({
    super.key,
    required this.delegate,
    this.children = const [],
  });

  final CommonDetailViewLayoutDelegate delegate;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final maxW = mediaQuery.size.width;
    final maxH = mediaQuery.size.height;
    final aspectRatio = mediaQuery.size.aspectRatio;

    if (maxW >= 900) {
      if (aspectRatio >= kAspectRatio() && maxW > maxH) {
        return _WideDeviceLayout(delegate: delegate, children: children);
      }

      return _ThinDeviceLayout(delegate: delegate, children: children);
    }

    return _ThinDeviceLayout(delegate: delegate, children: children);
  }
}

/// {@template interfaces.widgets.common.common_detail_view_layout.delegate}
/// Required delegate for [CommonDetailViewLayout].
///
/// This delegate used to provide data for the view headline.
/// {@endtemplate}
class CommonDetailViewLayoutDelegate {
  /// {@macro interfaces.widgets.common.common_detail_view_layout.delegate}
  const CommonDetailViewLayoutDelegate({
    required this.isViewHasAppBar,
    this.posterImageUrl,
    this.backdropImageUrl,
    required this.title,
    required this.subtitle,
    this.tagline,
    required this.overview,
    required this.extras,
  });

  /// Will crop the headline to fit the wide device screen.
  final bool isViewHasAppBar;

  /// Main image to shown. Make sure its potrait image for better ui.
  final String? posterImageUrl;

  /// Secondary image to shown. Make sure its landscape image for better ui.
  final String? backdropImageUrl;

  /// The title of the product.
  final String title;

  /// Shown below [title].
  ///
  /// Typically a [Text].
  final Widget subtitle;

  /// Same style and shown below [subtitle]. It will start with "#" on the ui, so
  /// make sure the [tagline] you provide did'nt start with "#".
  ///
  /// Render nothing if its null or empty string.
  final String? tagline;

  /// The overview of the product.
  final String overview;

  /// Extras to shown below [overview]. This will rendered in order like
  /// [Column.children].
  ///
  /// Typically a list of stats of the product.
  /// ```
  /// [
  ///   'Status: Released',
  ///   'Budget: $100.000.000',
  /// ]
  /// ```
  final List<String> extras;
}

const _kScrollViewPadding = EdgeInsets.only(bottom: 16.0);

class _ThinDeviceLayout extends StatelessWidget {
  const _ThinDeviceLayout({required this.delegate, required this.children});

  final CommonDetailViewLayoutDelegate delegate;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final maxW = screenSize.width;
    final maxH = screenSize.height > 800 ? 800 : screenSize.height;
    final aspectRatio = maxW / maxH;

    final isShowPoster = aspectRatio <= kAspectRatio() && maxH > maxW;

    return SingleChildScrollView(
      padding: _kScrollViewPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: maxW,
            height: (maxH * 0.8) - kToolbarHeight,
            child: CommonNetworkImage(
              imageUrl: isShowPoster
                  ? '${delegate.posterImageUrl}'
                  : '${delegate.backdropImageUrl}',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
          _DetailSection(delegate),
          ...children.isEmpty
              ? []
              : [
                  const Padding(padding: kHorizPadding, child: Divider()),
                  ...children
                ],
        ],
      ),
    );
  }
}

class _WideDeviceLayout extends StatelessWidget {
  const _WideDeviceLayout({required this.delegate, required this.children});

  final CommonDetailViewLayoutDelegate delegate;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    const minH = 400.0;
    final maxH = screenSize.height > 600 ? 600 : screenSize.height;

    final theme = Theme.of(context);
    final scaffoldBgColor = theme.scaffoldBackgroundColor;

    return SingleChildScrollView(
      padding: _kScrollViewPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // detail section with bg and poster image
          SizedBox(
            height: (maxH < minH ? minH : maxH) -
                (delegate.isViewHasAppBar ? kToolbarHeight : 0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // bg image
                CommonNetworkImage(
                  imageUrl: '${delegate.backdropImageUrl}',
                  fit: BoxFit.cover,
                ),
                // bg deco
                Container(
                  color: (theme.brightness == Brightness.light)
                      ? scaffoldBgColor.darken(3).withOpacity(0.9)
                      : scaffoldBgColor.lighten(3).withOpacity(0.9),
                ),

                // detail section with poster image
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // poster image
                      Flexible(
                        flex: 2,
                        child: AspectRatio(
                          aspectRatio: kAspectRatio(),
                          child: Card(
                            child: CommonNetworkImage(
                              imageUrl: '${delegate.posterImageUrl}',
                              alt: delegate.title,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // detail section
                      Expanded(
                        flex: 3,
                        child: _DetailSection(
                          delegate,
                          isWideLayout: true,
                          padding: const EdgeInsets.all(16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...children.isEmpty
              ? []
              : [
                  const SizedBox(height: 16.0),
                  ...children,
                ],
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection(
    this.delegate, {
    this.isWideLayout = false,
    this.padding = kHorizPadding,
  });

  final CommonDetailViewLayoutDelegate delegate;
  final bool isWideLayout;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final tagline = delegate.tagline ?? '';

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            delegate.title,
            style: M3TextStyles.headlineLarge.toStyle(context),
          ),

          //
          DefaultTextStyle.merge(
            style: M3TextStyles.bodyMedium.toStyle(context, opacity: 0.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                delegate.subtitle,
                ...tagline.isEmpty ? [] : [Text(tagline)],
              ],
            ),
          ),

          //
          const SizedBox(height: 8.0),
          isWideLayout
              ? Expanded(
                  child: SingleChildScrollView(child: Text(delegate.overview)))
              : Text(delegate.overview),

          //
          const Divider(),
          ...delegate.extras.map((text) {
            return Builder(builder: (context) {
              return Text(
                text,
                style: M3TextStyles.titleSmall.toStyle(context, opacity: 0.75),
              );
            });
          }),
        ],
      ),
    );
  }
}
