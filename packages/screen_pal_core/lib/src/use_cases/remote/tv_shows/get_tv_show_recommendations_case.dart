import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetTvShowRecommendationsCase {
  const GetTvShowRecommendationsCase({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<List<TvShow>> execute(int tvShowId) {
    return _tvShowsRepo.getTvShowRecommendations(tvShowId);
  }
}
