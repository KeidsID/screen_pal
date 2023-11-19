import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// {@template screen_pal.interfaces.widgets.apps.MaterialText}
/// [Text] widget with style config based on
/// [M3 Typography Tokens](https://m3.material.io/styles/typography/type-scale-tokens#40fc37f8-3269-4aa3-9f28-c6113079ac5d).
///
/// Use this instead of using [Text]. Why?
///
/// * Easy configuration to use styles from [MaterialApp], so no need to recall
///   [Theme.of] to load the styles anymore. Just use [M3TextStyles] to set the
///   style.
///
/// * It has an [opacity] option, so there is no need to wrap the [Opacity]
///   widget anymore which follows
///   [performance best practices](https://docs.flutter.dev/perf/best-practices#minimize-use-of-opacity-and-clipping).
///
/// In case you only need the [TextStyle], you can use the [M3TextStyles]
/// extension by calling the [toStyle] method on the enum value
/// (of course you need [BuildContext] to fetch it).
/// ```dart
/// M3TextStyles.bodyMedium.toStyle(context); // return [TextStyle?] from [MaterialApp]
/// ```
/// {@endtemplate}
class MaterialText extends StatelessWidget {
  /// Create a
  /// {@macro screen_pal.interfaces.widgets.apps.MaterialText}
  const MaterialText(
    this.data, {
    super.key,
    this.style = M3TextStyles.bodyMedium,
    this.opacity = 1.0,
    this.isBold = false,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
  }) : assert(opacity >= 0.0 && opacity <= 1.0);

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String data;

  /// Define which [TextStyle] to fetch from [MaterialApp].
  final M3TextStyles style;

  /// Set the [Text] color with the given opacity (which ranges from 0.0 to 1.0).
  ///
  /// Out of range values will have unexpected effects.
  final double opacity;

  /// Define the text as bold, bold styling will be applied.
  final bool isBold;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// If this is null [TextStyle.overflow] will be used, otherwise the value
  /// from the nearest [DefaultTextStyle] ancestor will be used.
  final TextOverflow? overflow;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// {@macro flutter.widgets.Text.semanticsLabel}
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final textStyle = style.toStyle(context);
    final color = textStyle?.color;

    return Text(
      data,
      key: key,
      style: textStyle?.copyWith(
        color: color?.withOpacity(opacity),
        fontWeight: (isBold) ? FontWeight.bold : null,
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
      ..add(StringProperty('data', data, showName: false))
      ..add(EnumProperty<M3TextStyles>(
        'style',
        style,
        defaultValue: M3TextStyles.bodyMedium,
      ))
      ..add(DoubleProperty('opacity', opacity, defaultValue: 1))
      ..add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: null))
      ..add(EnumProperty<TextDirection>(
        'textDirection',
        textDirection,
        defaultValue: null,
      ))
      ..add(FlagProperty(
        'softWrap',
        value: softWrap,
        ifTrue: 'wrapping at box width',
        ifFalse: 'no wrapping except at line break characters',
        showName: true,
      ))
      ..add(EnumProperty<TextOverflow>(
        'overflow',
        overflow,
        defaultValue: null,
      ))
      ..add(IntProperty('maxLines', maxLines, defaultValue: null));

    if (semanticsLabel != null) {
      properties.add(StringProperty('semanticsLabel', semanticsLabel));
    }
  }
}

/// Enum for [MaterialText.style]. Can be converted to [TextStyle] by using
/// [toStyle] extension.
enum M3TextStyles {
  /// Largest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  displayLarge,

  /// Middle size of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  displayMedium,

  /// Smallest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  displaySmall,

  /// Largest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  headlineLarge,

  /// Middle size of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  headlineMedium,

  /// Smallest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  headlineSmall,

  /// Largest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  titleLarge,

  /// Middle size of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  titleMedium,

  /// Smallest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  titleSmall,

  /// Largest of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  bodyLarge,

  /// Middle size of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  ///
  /// The default text style for [Material].
  bodyMedium,

  /// Smallest of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  bodySmall,

  /// Largest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  ///
  /// Used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
  labelLarge,

  /// Middle size of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  labelMedium,

  /// Smallest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  labelSmall,
}

extension M3TextStylesExt on M3TextStyles {
  /// Convert the enum into [TextStyle].
  TextStyle? toStyle(BuildContext context) => _textStylesMap(context)[this];
}

Map<M3TextStyles, TextStyle?> _textStylesMap(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return {
    M3TextStyles.displayLarge: textTheme.displayLarge,
    M3TextStyles.displayMedium: textTheme.displayMedium,
    M3TextStyles.displaySmall: textTheme.displaySmall,
    M3TextStyles.headlineLarge: textTheme.headlineLarge,
    M3TextStyles.headlineMedium: textTheme.headlineMedium,
    M3TextStyles.headlineSmall: textTheme.headlineSmall,
    M3TextStyles.titleLarge: textTheme.titleLarge,
    M3TextStyles.titleMedium: textTheme.titleMedium,
    M3TextStyles.titleSmall: textTheme.titleSmall,
    M3TextStyles.bodyLarge: textTheme.bodyLarge,
    M3TextStyles.bodyMedium: textTheme.bodyMedium,
    M3TextStyles.bodySmall: textTheme.bodySmall,
    M3TextStyles.labelLarge: textTheme.labelLarge,
    M3TextStyles.labelMedium: textTheme.labelMedium,
    M3TextStyles.labelSmall: textTheme.labelSmall,
  };
}
