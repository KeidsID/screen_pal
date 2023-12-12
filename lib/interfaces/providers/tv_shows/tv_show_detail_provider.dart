// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/service_locator/locator.dart'
    as service;
import 'package:screen_pal/core/entities/tv_shows/tv_show_detail.dart';
import 'package:screen_pal/core/use_cases/tv_shows/get_tv_show_detail.dart';

part 'tv_show_detail_provider.g.dart';

@riverpod
Future<TvShowDetail> tvShowDetail(TvShowDetailRef ref, int tvShowId) {
  return service.locator<GetTvShowDetail>().execute(tvShowId);
}
