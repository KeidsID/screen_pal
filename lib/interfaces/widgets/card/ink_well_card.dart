import 'package:flutter/material.dart';

class InkWellCard extends StatelessWidget {
  const InkWellCard({
    super.key,
    this.clipBehavior,
    this.elevation,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.child,
  });

  final Clip? clipBehavior;
  final double? elevation;
  final EdgeInsetsGeometry? margin;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: clipBehavior,
      elevation: elevation,
      margin: margin,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        onHover: onHover,
        child: child,
      ),
    );
  }
}
