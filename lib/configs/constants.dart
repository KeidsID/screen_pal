import 'dart:io';

import 'package:flutter/foundation.dart';

const kAppName = 'Screen Pal';
const kAppLegalese = 'Copyright (c) 2023 KeidsID (Kemal Idris)';
const kTmdbApiVersion = '3';

final kIsMobile = kIsWeb ? false : Platform.isAndroid || Platform.isIOS;
