// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:screen_pal/infrastructures/container/container.dart' as service;
import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/core/use_cases/remote/movies/get_movie_collection_detail.dart';

part 'movie_collection_detail_provider.g.dart';

@riverpod
Future<MovieCollectionDetail> movieCollectionDetail(
  MovieCollectionDetailRef ref,
  int collectionId,
) {
  return service.locator<GetMovieCollectionDetail>().execute(collectionId);
}
