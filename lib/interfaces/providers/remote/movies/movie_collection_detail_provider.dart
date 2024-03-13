// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal_core/screen_pal_core.dart';

part 'movie_collection_detail_provider.g.dart';

@riverpod
Future<MovieCollectionDetail> movieCollectionDetail(
  MovieCollectionDetailRef ref,
  int collectionId,
) {
  return service.locator<GetMovieCollectionDetailCase>().execute(collectionId);
}
