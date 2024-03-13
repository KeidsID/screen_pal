import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetTvShowCreditsCase {
  final TvShowsRepo _moviesRepo;

  const GetTvShowCreditsCase({required TvShowsRepo tvShowsRepo})
      : _moviesRepo = tvShowsRepo;

  Future<Credits> execute(int tvShowId) =>
      _moviesRepo.getTvShowCredits(tvShowId);
}
