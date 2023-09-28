// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// TMDB logos from assets always render black. Use this [ShaderMask] to render
/// it correctly.
class TmdbLogoShaderMask extends StatelessWidget {
  /// Create a [ShaderMask] to render the TMDB .svg logos color correctly.
  const TmdbLogoShaderMask({super.key, this.child});

  final SvgPicture? child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xff90cea1), Color(0xff01b4e4)],
      ).createShader(rect),
      blendMode: BlendMode.srcIn,
      child: child,
    );
  }
}
