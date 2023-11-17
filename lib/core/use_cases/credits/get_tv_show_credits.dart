import 'package:screen_pal/core/entities/credits/credits.dart';
import 'package:screen_pal/core/repo/tv_shows_repo.dart';

final class GetTvShowCredits {
  final TvShowsRepo _moviesRepo;

  const GetTvShowCredits({required TvShowsRepo tvShowsRepo})
      : _moviesRepo = tvShowsRepo;

  Future<Credits> execute(int tvShowId) =>
      _moviesRepo.getTvShowCredits(tvShowId);
}
