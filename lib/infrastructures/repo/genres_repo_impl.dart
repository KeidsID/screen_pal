import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:screen_pal/core/entities/genre.dart';
import 'package:screen_pal/core/repo/genres_repo.dart';

class GenresRepoImpl implements GenresRepo {
  const GenresRepoImpl(Dio dio) : _dio = dio;

  final Dio _dio;

  static const _basePath = '/genre';

  @override
  Future<List<Genre>> getMovieGenres() async {
    final response = await _dio.get<String>('$_basePath/movie/list');

    final resBodyMap = jsonDecode(response.data!) as Map<String, dynamic>;

    return List<Genre>.from((resBodyMap['genres'] as List).map((e) {
      return Genre.fromMap(e);
    }));
  }

  @override
  Future<List<Genre>> getTvShowGenres() async {
    final response = await _dio.get<String>('$_basePath/tv/list');

    final resBodyMap = jsonDecode(response.data!) as Map<String, dynamic>;

    return List<Genre>.from((resBodyMap['genres'] as List).map((e) {
      return Genre.fromMap(e);
    }));
  }
}
