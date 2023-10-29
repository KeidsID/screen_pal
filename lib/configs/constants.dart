// coverage:ignore-file

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:screen_pal/interfaces/widgets/others/material_text.dart';

const kAppName = 'Screen Pal';
const kAppLegalese = 'Copyright (c) 2023 KeidsID (Kemal Idris)';
const kTmdbApiVersion = '3';

/// Use this to debug instead [debugPrint].
final kLogger = Logger();
final kIsMobile = kIsWeb ? false : Platform.isAndroid || Platform.isIOS;

const kHorizPadding = EdgeInsets.symmetric(horizontal: 16.0);

const kSectionTitleStyle = M3TextStyles.headlineSmall;

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
