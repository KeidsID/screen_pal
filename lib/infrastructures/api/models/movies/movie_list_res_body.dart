// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'raw_movie.dart';

part 'movie_list_res_body.freezed.dart';
part 'movie_list_res_body.g.dart';

/// TMDB Api response body for requesting movies.
@freezed
class MovieListResBody with _$MovieListResBody {
  const factory MovieListResBody({
    required int page,
    required List<RawMovie> results,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _MovieListResBody;

  factory MovieListResBody.fromJson(Map<String, dynamic> json) =>
      _$MovieListResBodyFromJson(json);
}
