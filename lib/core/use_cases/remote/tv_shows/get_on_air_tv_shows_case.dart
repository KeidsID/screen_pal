import 'package:screen_pal/core/entities/tv_shows/tv_show.dart';
import 'package:screen_pal/core/services/remote/tv_shows_repo.dart';

final class GetOnAirTvShowsCase {
  const GetOnAirTvShowsCase({required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo;

  final TvShowsRepo _tvShowsRepo;

  Future<List<TvShow>> execute() => _tvShowsRepo.getOnAirTvShows();
}
