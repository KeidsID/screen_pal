// coverage:ignore-file

part of '../routes.dart';

final _tvShowsRoute = GoRoute(
  path: '/tv-shows',
  builder: (_, __) => const TvShowsHomeView(),
);
