// coverage:ignore-file

import 'package:flutter/material.dart';

/// https://stackoverflow.com/a/76264049/19337625
class DialogPage<T> extends Page<T> {
  final WidgetBuilder builder;
  final CapturedThemes? themes;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final Offset? anchorPoint;
  final bool useSafeArea;

  /// Create a [Page] that suitable for [Dialog]. This is the same as calling
  /// the [showDialog] method, but this [Page] can work with [GoRouter].
  const DialogPage({
    required this.builder,
    this.themes,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.anchorPoint,
    this.useSafeArea = true,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      builder: builder,
      settings: this,
      themes: themes,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      anchorPoint: anchorPoint,
      useSafeArea: useSafeArea,
    );
  }
}
