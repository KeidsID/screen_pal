import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:screen_pal/core/entities/genre.dart';
import 'package:screen_pal/core/repo/genres_repo.dart';
import 'package:screen_pal/infrastructures/api/models/movie/raw_genre.dart';

class GenresRepoImpl implements GenresRepo {
  const GenresRepoImpl(Dio dio) : _dio = dio;

  final Dio _dio;

  static const _basePath = '/genre';

  @override
  Future<List<Genre>> getMovieGenres() async {
    final response = await _dio.get<String>('$_basePath/movie/list');
    final rawResBody = jsonDecode(response.data!) as Map<String, dynamic>;

    return List<RawGenre>.from((rawResBody['genres'] as List).map((e) {
      return RawGenre.fromJson(e);
    })).map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Genre>> getTvShowGenres() async {
    final response = await _dio.get<String>('$_basePath/tv/list');
    final rawResBody = jsonDecode(response.data!) as Map<String, dynamic>;

    return List<RawGenre>.from((rawResBody['genres'] as List).map((e) {
      return RawGenre.fromJson(e);
    })).map((e) => e.toEntity()).toList();
  }
}
