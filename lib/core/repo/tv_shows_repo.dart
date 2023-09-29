import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';

/// Everything you need to manage Tv Shows.
abstract interface class TvShowsRepo {
  Future<List<TvShow>> getAiringTodayTvShows();
  Future<List<TvShow>> getOnAirTvShows();
  Future<List<TvShow>> getPopularTvShows();
  Future<List<TvShow>> getTopRatedTvShows();
}
