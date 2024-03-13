import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetTvShowFullCreditsCase {
  const GetTvShowFullCreditsCase({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<TvCredits> execute(int tvShowId) =>
      _tvShowsRepo.getTvShowFullCredits(tvShowId);
}
