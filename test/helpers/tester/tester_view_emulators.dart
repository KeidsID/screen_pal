import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Contain static methods to emulate device into the [WidgetTester].
///
/// ```dart
/// // emulate 712 x 1138 view.
/// TesterViewEmulators.galaxyTabS4(tester);
///
/// // emulate 1138 x 712 view.
/// TesterViewEmulators.galaxyTabS4(tester, isPotrait: false);
/// ```
abstract final class TesterViewEmulators {
  static Size _getTestableSize(
    WidgetTester tester, {
    required double width,
    required double height,
    bool isPotrait = true,
  }) {
    final dpi = tester.view.devicePixelRatio;

    final w = width * dpi;
    final h = height * dpi;

    return isPotrait ? Size(w, h) : Size(h, w);
  }

  /// Will emulate the view of a `Mobile` device (412 x 915 on potrait).
  static void samsungGalaxyS20Ultra(
    WidgetTester tester, {
    bool isPotrait = true,
  }) {
    final testableSize = _getTestableSize(
      tester,
      width: 412,
      height: 915,
      isPotrait: isPotrait,
    );

    tester.view.physicalSize = testableSize;
  }

  /// Will emulate the view of a `Tablet` device (712 x 1138 on potrait).
  static void galaxyTabS4(WidgetTester tester, {bool isPotrait = true}) {
    final size = _getTestableSize(
      tester,
      width: 712,
      height: 1138,
      isPotrait: isPotrait,
    );

    tester.view.physicalSize = size;
  }

  /// Will emulate the view of a `Tablet L`/`Laptop` device (1024 x 1366 on potrait).
  static void iPadPro(WidgetTester tester, {bool isPotrait = true}) {
    final size = _getTestableSize(
      tester,
      width: 1024,
      height: 1366,
      isPotrait: isPotrait,
    );

    tester.view.physicalSize = size;
  }

  /// Will emulate the view of a `Laptop L` device (1920 x 1080).
  static void asusVivobook14(WidgetTester tester) {
    final size = _getTestableSize(tester, width: 1920, height: 1080);

    tester.view.physicalSize = size;
  }
}
