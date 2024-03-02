// coverage:ignore-file

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:screen_pal/interfaces/utils/m3_text_styles.dart';

const kAppName = 'Screen Pal';
const kAppLegalese = 'MIT License\n\nCopyright © 2023 KeidsID (Kemal Idris)';
const kTmdbApiVersion = '3';

/// Use this to debug instead [debugPrint].
final kLogger = Logger();
bool get kIsMobile {
  if (kIsWeb) {
    final platform = defaultTargetPlatform;

    return platform == TargetPlatform.android || platform == TargetPlatform.iOS;
  }

  return Platform.isAndroid;
}

const kHorizPadding = EdgeInsets.symmetric(horizontal: 16.0);

const kSectionTitleStyle = M3TextStyles.headlineSmall;

double kAspectRatio({bool isPotrait = true}) => (isPotrait) ? 2 / 3 : 3 / 2;

/// Set [value] as true if the widget are visible to user.
FlagProperty kIsVisibleFlagProperty(bool value) {
  return FlagProperty(
    'isVisible',
    value: value,
    ifTrue: 'Widget contents rendered',
    ifFalse: 'SizedBox with zero size rendered',
    showName: true,
  );
}
