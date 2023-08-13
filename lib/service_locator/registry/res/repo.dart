import '../../../core/repo/movie_repo.dart';
import '../../../infrastructures/api/tmdb_dio.dart';
import '../../../infrastructures/repo/movie_repo_impl.dart';
import '../../locator.dart';

void registerRepo() {
  locator.registerLazySingleton<MovieRepo>(() => MovieRepoImpl(tmdbDio));
}
