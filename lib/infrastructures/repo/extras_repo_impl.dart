import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:screen_pal/core/entities/extras/genre.dart';
import 'package:screen_pal/core/entities/extras/spoken_language.dart';
import 'package:screen_pal/core/repo/extras_repo.dart';
import 'package:screen_pal/infrastructures/api/models/movies/raw_genre.dart';
import 'package:screen_pal/infrastructures/api/models/movies/raw_spoken_language.dart';

class ExtrasRepoImpl implements ExtrasRepo {
  const ExtrasRepoImpl(Dio dio) : _dio = dio;

  final Dio _dio;

  static const _genrePath = '/genre';

  @override
  Future<List<SpokenLanguage>> getLanguages() async {
    final response = await _dio.get<String>('/configuration/languages');
    final rawResBody = jsonDecode(response.data!) as List;

    return rawResBody
        .map((e) => RawSpokenLanguage.fromJson(e))
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<List<Genre>> getMovieGenres() async {
    final response = await _dio.get<String>('$_genrePath/movie/list');
    final rawResBody = jsonDecode(response.data!) as Map<String, dynamic>;

    return (rawResBody['genres'] as List)
        .map((e) => RawGenre.fromJson(e))
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<List<Genre>> getTvShowGenres() async {
    final response = await _dio.get<String>('$_genrePath/tv/list');
    final rawResBody = jsonDecode(response.data!) as Map<String, dynamic>;

    return (rawResBody['genres'] as List)
        .map((e) => RawGenre.fromJson(e))
        .map((e) => e.toEntity())
        .toList();
  }
}
