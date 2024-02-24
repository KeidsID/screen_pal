import 'package:screen_pal/core/entities/credits/credits.dart';
import 'package:screen_pal/core/services/remote/tv_shows_repo.dart';

final class GetTvShowCreditsCase {
  final TvShowsRepo _moviesRepo;

  const GetTvShowCreditsCase({required TvShowsRepo tvShowsRepo})
      : _moviesRepo = tvShowsRepo;

  Future<Credits> execute(int tvShowId) =>
      _moviesRepo.getTvShowCredits(tvShowId);
}
