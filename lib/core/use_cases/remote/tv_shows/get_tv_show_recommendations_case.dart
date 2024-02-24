import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';
import 'package:screen_pal/core/services/remote/tv_shows_repo.dart';

final class GetTvShowRecommendationsCase {
  const GetTvShowRecommendationsCase({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<List<TvShow>> execute(int tvShowId) {
    return _tvShowsRepo.getTvShowRecommendations(tvShowId);
  }
}
