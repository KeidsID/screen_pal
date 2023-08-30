// coverage:ignore-file

import 'dart:io';

import 'package:flutter/foundation.dart';

const kAppName = 'Screen Pal';
final kIsMobile = kIsWeb ? false : Platform.isAndroid || Platform.isIOS;
