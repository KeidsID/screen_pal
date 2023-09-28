import 'package:mockito/annotations.dart';
import 'package:screen_pal/core/repo/app_settings_repo.dart';
import 'package:screen_pal/core/repo/extras_repo.dart';
import 'package:screen_pal/core/repo/movies_repo.dart';
import 'package:screen_pal/core/repo/tv_shows_repo.dart';

@GenerateMocks([
  AppSettingsRepo,
  ExtrasRepo,
  MoviesRepo,
  TvShowsRepo,
])
void main() {}
