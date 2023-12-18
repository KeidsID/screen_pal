import 'package:flutter/material.dart';

/// {@template interfaces.widgets.common.sized_circular_progress_indicator}
/// This just [SizedBox]>[Center]>[CircularProgressIndicator] in widget tree.
/// {@endtemplate}
class SizedCircularProgressIndicator extends StatelessWidget {
  const SizedCircularProgressIndicator({
    super.key,
    this.width,
    this.height,
    this.value,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
  });

  /// {@macro interfaces.widgets.common.sized_circular_progress_indicator}
  const SizedCircularProgressIndicator.expand({
    super.key,
    this.value,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
  })  : width = double.infinity,
        height = double.infinity;

  /// {@macro interfaces.widgets.common.sized_circular_progress_indicator}
  const SizedCircularProgressIndicator.shrink({
    super.key,
    this.value,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
  })  : width = 0.0,
        height = 0.0;

  /// {@macro interfaces.widgets.common.sized_circular_progress_indicator}
  SizedCircularProgressIndicator.fromSize({
    super.key,
    this.value,
    Size? size,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
  })  : width = size?.width,
        height = size?.height;

  /// {@macro interfaces.widgets.common.sized_circular_progress_indicator}
  const SizedCircularProgressIndicator.square({
    super.key,
    this.value,
    double? dimension,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
  })  : width = dimension,
        height = dimension;

  /// If non-null, requires the child to have exactly this width.
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  /// If non-null, the value of this progress indicator.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  /// The value will be clamped to be in the range 0.0-1.0.
  ///
  /// If null, this progress indicator is indeterminate, which means the
  /// indicator displays a predetermined animation that does not indicate how
  /// much actual progress is being made.
  final double? value;

  /// The progress indicator's background color.
  ///
  /// It is up to the subclass to implement this in whatever way makes sense
  /// for the given use case. See the subclass documentation for details.
  final Color? backgroundColor;

  /// {@macro flutter.progress_indicator.ProgressIndicator.color}
  final Color? color;

  /// The progress indicator's color as an animated value.
  ///
  /// If null, the progress indicator is rendered with [color]. If that is null,
  /// then it will use the ambient [ProgressIndicatorThemeData.color]. If that
  /// is also null then it defaults to the current theme's [ColorScheme.primary].
  final Animation<Color?>? valueColor;

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  /// {@macro flutter.progress_indicator.ProgressIndicator.semanticsLabel}
  final String? semanticsLabel;

  /// {@macro flutter.progress_indicator.ProgressIndicator.semanticsValue}
  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: CircularProgressIndicator(
          value: value,
          backgroundColor: backgroundColor,
          color: color,
          valueColor: valueColor,
          strokeWidth: strokeWidth,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        ),
      ),
    );
  }
}
