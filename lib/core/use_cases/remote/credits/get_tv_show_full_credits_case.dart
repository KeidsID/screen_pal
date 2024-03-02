import 'package:screen_pal/core/entities/credits/tv_credits.dart';
import 'package:screen_pal/core/services/remote/tv_shows_repo.dart';

final class GetTvShowFullCreditsCase {
  const GetTvShowFullCreditsCase({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<TvCredits> execute(int tvShowId) =>
      _tvShowsRepo.getTvShowFullCredits(tvShowId);
}
