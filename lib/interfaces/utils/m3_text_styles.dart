import 'package:flutter/material.dart';

/// [TextStyle] enum from [TextTheme]. Can be converted to [TextStyle] by using
/// [toStyle] extension.
/// ```
/// M3TextStyles.bodyMedium.toStyle(context); // material default text style
/// ```
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

extension M3TextStylesX on M3TextStyles {
  /// Convert the enum into [TextStyle].
  ///
  /// - [opacity], set the text style opacity.
  /// - [isBold], apply [FontWeight.bold] if true.
  TextStyle? toStyle(
    BuildContext context, {
    double opacity = 1.0,
    bool isBold = false,
  }) {
    final style = _textStylesMap(context)[this];
    final color = style?.color;

    return style?.copyWith(
      color: color?.withOpacity(opacity),
      fontWeight: (isBold) ? FontWeight.bold : null,
    );
  }
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
