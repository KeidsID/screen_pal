// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/interfaces/router/utils/dialog_page.dart';
import 'package:screen_pal/interfaces/views/home_view_layout.dart';
import 'package:screen_pal/interfaces/views/movies/movie_collection_detail_view.dart';
import 'package:screen_pal/interfaces/views/movies/movie_detail_view.dart';
import 'package:screen_pal/interfaces/views/movies/movies_home_view.dart';
import 'package:screen_pal/interfaces/views/settings_view.dart';
import 'package:screen_pal/interfaces/widgets/dialogs/about_app_dialog.dart';
import 'package:screen_pal/interfaces/widgets/dialogs/about_tmdb_dialog.dart';
import 'package:screen_pal/interfaces/widgets/errors/bad_request_error_view.dart';
import 'package:screen_pal/interfaces/widgets/errors/unknown_error_widget.dart';

part 'res/movies_route.dart';
part 'res/settings_route.dart';
part 'res/tv_shows_route.dart';

final List<RouteBase> routes = [
  ShellRoute(
    builder: (_, __, child) => HomeViewLayout(child: child),
    routes: [
      _moviesRoute,
      _tvShowsRoute,
    ],
  ),
  _settingsRoute,
];
