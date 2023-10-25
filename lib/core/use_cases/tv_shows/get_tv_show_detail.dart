import 'package:screen_pal/core/entities/tv_shows/tv_show_detail.dart';
import 'package:screen_pal/core/repo/tv_shows_repo.dart';

final class GetTvShowDetail {
  const GetTvShowDetail({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<TvShowDetail> execute(int tvShowId) {
    return _tvShowsRepo.getTvShowDetail(tvShowId);
  }
}
