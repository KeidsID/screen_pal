// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:screen_pal/core/entities/genre.dart';

part 'raw_genre.freezed.dart';
part 'raw_genre.g.dart';

/// TMDB Api object model for movie/tv show genres.
@freezed
class RawGenre with _$RawGenre {
  const RawGenre._();

  const factory RawGenre({required int id, required String name}) = _RawGenre;

  factory RawGenre.fromJson(Map<String, dynamic> json) =>
      _$RawGenreFromJson(json);

  Genre toEntity() => Genre(id: id, name: name);
}
