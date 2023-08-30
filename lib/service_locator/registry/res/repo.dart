import '../../../core/repo/movies_repo.dart';
import '../../../infrastructures/api/tmdb_dio.dart';
import '../../../infrastructures/repo/movies_repo_impl.dart';
import '../../locator.dart';

void registerRepo() {
  locator.registerLazySingleton<MoviesRepo>(() => MoviesRepoImpl(tmdbDio));
}
