import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetTvShowDetailCase {
  const GetTvShowDetailCase({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<TvShowDetail> execute(int tvShowId) {
    return _tvShowsRepo.getTvShowDetail(tvShowId);
  }
}
