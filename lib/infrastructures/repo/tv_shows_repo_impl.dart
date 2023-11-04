import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';
import 'package:screen_pal/core/entities/tv_shows/tv_show_detail.dart';
import 'package:screen_pal/core/repo/tv_shows_repo.dart';
import 'package:screen_pal/infrastructures/api/models/tv_shows/raw_tv_show_detail.dart';
import 'package:screen_pal/infrastructures/api/models/tv_shows/tv_show_list_res_body.dart';

class TvShowsRepoImpl implements TvShowsRepo {
  const TvShowsRepoImpl(Dio dio) : _dio = dio;

  final Dio _dio;

  static const _tvShowPath = '/tv';

  @override
  Future<List<TvShow>> getAiringTodayTvShows() async {
    final response = await _dio.get<String>('$_tvShowPath/airing_today');
    final rawResBody = jsonDecode(response.data!);

    final resBody = TvShowListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<TvShow>> getOnAirTvShows() async {
    final response = await _dio.get<String>('$_tvShowPath/on_the_air');
    final rawResBody = jsonDecode(response.data!);

    final resBody = TvShowListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<TvShow>> getPopularTvShows() async {
    final response = await _dio.get<String>('$_tvShowPath/popular');
    final rawResBody = jsonDecode(response.data!);

    final resBody = TvShowListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<TvShow>> getTopRatedTvShows() async {
    final response = await _dio.get<String>('$_tvShowPath/top_rated');
    final rawResBody = jsonDecode(response.data!);

    final resBody = TvShowListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }

  @override
  Future<TvShowDetail> getTvShowDetail(int tvShowId) async {
    final response = await _dio.get<String>('$_tvShowPath/$tvShowId');
    final rawResBody = jsonDecode(response.data!);

    final resBody = RawTvShowDetail.fromJson(rawResBody);

    return resBody.toEntity();
  }

  @override
  Future<List<TvShow>> getTvShowRecommendations(int tvShowId) async {
    final response =
        await _dio.get<String>('$_tvShowPath/$tvShowId/recommendations');
    final rawResBody = jsonDecode(response.data!);

    final resBody = TvShowListResBody.fromJson(rawResBody);

    return resBody.results.map((e) => e.toEntity()).toList();
  }
}