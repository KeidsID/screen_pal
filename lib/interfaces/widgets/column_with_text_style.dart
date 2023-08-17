import 'package:flutter/material.dart';

class ColumnWithTextStyle extends StatelessWidget {
  const ColumnWithTextStyle({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    required this.crossAxisAlignment,
    this.textDirection,
    required this.verticalDirection,
    this.textBaseline,
    this.children = const <Widget>[],
  }) : super(key: key);

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );
  }
}
