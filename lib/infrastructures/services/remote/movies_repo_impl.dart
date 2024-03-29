import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:screen_pal/infrastructures/tmdb/models/credits/raw_credits.dart';
import 'package:screen_pal/infrastructures/tmdb/models/movies/movie_list_res_body.dart';
import 'package:screen_pal/infrastructures/tmdb/models/movies/raw_movie_collection_detail.dart';
import 'package:screen_pal/infrastructures/tmdb/models/movies/raw_movie_detail.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

class MoviesRepoImpl implements MoviesRepo {
  const MoviesRepoImpl(Dio dio) : _dio = dio;

  final Dio _dio;

  static const _moviePath = '/movie';

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await _dio.get<String>('$_moviePath/now_playing');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getPopularMovies() async {
    final response = await _dio.get<String>('$_moviePath/popular');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    final response = await _dio.get<String>('$_moviePath/top_rated');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    final response = await _dio.get<String>('$_moviePath/upcoming');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getRecommendations(int movieId) async {
    final response =
        await _dio.get<String>('$_moviePath/$movieId/recommendations');
    final rawResBody = jsonDecode(response.data!);

    final resBody = MovieListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<MovieDetail> getMovieDetail(int movieId) async {
    final response = await _dio.get<String>('$_moviePath/$movieId');
    final rawResBody = jsonDecode(response.data!);

    final resBody = RawMovieDetail.fromJson(rawResBody);

    return resBody.toEntity();
  }

  @override
  Future<Credits> getMovieCredits(int movieId) async {
    final response = await _dio.get<String>('$_moviePath/$movieId/credits');
    final rawResBody = jsonDecode(response.data!);

    final resBody = RawCredits.fromJson(rawResBody);

    return resBody.toEntity();
  }

  @override
  Future<MovieCollectionDetail> getMovieCollectionDetail(
    int collectionId,
  ) async {
    final response = await _dio.get<String>('/collection/$collectionId');
    final rawResBody = jsonDecode(response.data!);

    final resBody = RawMovieCollectionDetail.fromJson(rawResBody);

    return resBody.toEntity();
  }
}
