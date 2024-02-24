import 'package:screen_pal/core/entities/tv_shows/tv_show_detail.dart';
import 'package:screen_pal/core/services/remote/tv_shows_repo.dart';

final class GetTvShowDetailCase {
  const GetTvShowDetailCase({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<TvShowDetail> execute(int tvShowId) {
    return _tvShowsRepo.getTvShowDetail(tvShowId);
  }
}
