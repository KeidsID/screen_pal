import 'package:screen_pal/core/entities/credits/tv_full_credits.dart';
import 'package:screen_pal/core/services/remote/tv_shows_repo.dart';

final class GetTvShowFullCredits {
  const GetTvShowFullCredits({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<TvFullCredits> execute(int tvShowId) =>
      _tvShowsRepo.getTvShowFullCredits(tvShowId);
}
