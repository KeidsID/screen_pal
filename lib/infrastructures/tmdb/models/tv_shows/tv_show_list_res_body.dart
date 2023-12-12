// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'raw_tv_show.dart';

part 'tv_show_list_res_body.freezed.dart';
part 'tv_show_list_res_body.g.dart';

/// TMDB Api response body for requesting tv shows.
@freezed
class TvShowListResBody with _$TvShowListResBody {
  const factory TvShowListResBody({
    required int page,
    required List<RawTvShow> results,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _TvShowListResBody;

  factory TvShowListResBody.fromJson(Map<String, dynamic> json) =>
      _$TvShowListResBodyFromJson(json);
}
