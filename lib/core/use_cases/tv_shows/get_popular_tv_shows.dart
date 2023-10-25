import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';
import 'package:screen_pal/core/repo/tv_shows_repo.dart';

final class GetPopularTvShows {
  const GetPopularTvShows({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<List<TvShow>> execute() => _tvShowsRepo.getPopularTvShows();
}
