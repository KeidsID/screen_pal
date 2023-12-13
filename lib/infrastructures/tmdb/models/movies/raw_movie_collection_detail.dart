// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/infrastructures/tmdb/utils/tmdb_images_config.dart';

import 'raw_movie.dart';

part 'raw_movie_collection_detail.freezed.dart';
part 'raw_movie_collection_detail.g.dart';

@freezed
class RawMovieCollectionDetail with _$RawMovieCollectionDetail {
  const RawMovieCollectionDetail._();

  const factory RawMovieCollectionDetail({
    required int id,
    required String name,
    required String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    required List<RawMovie> parts,
  }) = _RawMovieCollectionDetail;

  factory RawMovieCollectionDetail.fromJson(Map<String, dynamic> json) =>
      _$RawMovieCollectionDetailFromJson(json);

  MovieCollectionDetail toEntity() {
    return MovieCollectionDetail(
      id: id,
      name: name,
      overview: overview,
      posterImageUrl: TmdbPosterImageSizes.original.secureFetchUrl(posterPath),
      backdropImageUrl:
          TmdbBackdropImageSizes.original.secureFetchUrl(backdropPath),
      parts: parts.map((e) => e.toEntity()).toList(),
    );
  }
}
