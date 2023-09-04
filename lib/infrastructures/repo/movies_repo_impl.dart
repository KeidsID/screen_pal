import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/core/entities/movie_detail.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';
import 'package:screen_pal/infrastructures/api/models/movie/movie_detail_res_body.dart';
import 'package:screen_pal/infrastructures/api/models/movie/movie_list_res_body.dart';

class MoviesRepoImpl implements MoviesRepo {
  const MoviesRepoImpl(Dio dio) : _dio = dio;

  final Dio _dio;

  static const _basePath = '/movie';

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await _dio.get<String>('$_basePath/now_playing');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getPopularMovies() async {
    final response = await _dio.get<String>('$_basePath/popular');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    final response = await _dio.get<String>('$_basePath/top_rated');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    final response = await _dio.get<String>('$_basePath/upcoming');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<MovieDetail> getMovieDetail(int id) async {
    final response = await _dio.get<String>('$_basePath/$id');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieDetailResBody.fromJson(rawResBody);

    return resBody.toEntity();
  }
}
