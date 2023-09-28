// coverage:ignore-file

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

const kAppName = 'Screen Pal';
const kAppLegalese = 'Copyright (c) 2023 KeidsID (Kemal Idris)';
const kTmdbApiVersion = '3';

/// Use this to debug instead [debugPrint].
final kLogger = Logger();

final kIsMobile = kIsWeb ? false : Platform.isAndroid || Platform.isIOS;
