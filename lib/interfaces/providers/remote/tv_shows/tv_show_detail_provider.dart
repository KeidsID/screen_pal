// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal_core/screen_pal_core.dart';

part 'tv_show_detail_provider.g.dart';

@riverpod
Future<TvShowDetail> tvShowDetail(TvShowDetailRef ref, int tvShowId) {
  return service.locator<GetTvShowDetailCase>().execute(tvShowId);
}
