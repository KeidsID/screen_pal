import 'package:screen_pal_core/src/entities.dart';

/// Everything you need to manage Tv Shows.
abstract interface class TvShowsRepo {
  Future<List<TvShow>> getAiringTodayTvShows();
  Future<List<TvShow>> getOnAirTvShows();
  Future<List<TvShow>> getPopularTvShows();
  Future<List<TvShow>> getTopRatedTvShows();
  Future<List<TvShow>> getTvShowRecommendations(int tvShowId);

  Future<TvShowDetail> getTvShowDetail(int tvShowId);
  Future<Credits> getTvShowCredits(int tvShowId);
  Future<TvCredits> getTvShowFullCredits(int tvShowId);
}
