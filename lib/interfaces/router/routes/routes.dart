// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/interfaces/router/utils/dialog_page.dart';
import 'package:screen_pal/interfaces/views.dart';
import 'package:screen_pal/interfaces/widgets.dart';

part 'res/movies_route.dart';
part 'res/settings_route.dart';
part 'res/tv_shows_route.dart';

final List<RouteBase> routes = [
  ShellRoute(
    builder: (_, __, child) => HomeViewLayout(child: child),
    routes: [
      _moviesRoute,
      _tvShowsRoute,
      _settingsRoute,
    ],
  ),
];
