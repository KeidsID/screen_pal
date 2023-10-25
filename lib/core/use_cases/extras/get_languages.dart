import 'package:screen_pal/core/entities/extras/spoken_language.dart';
import 'package:screen_pal/core/repo/extras_repo.dart';

final class GetLanguages {
  const GetLanguages({required ExtrasRepo extrasRepo})
      : _extrasRepo = extrasRepo;

  final ExtrasRepo _extrasRepo;

  Future<List<SpokenLanguage>> execute() => _extrasRepo.getLanguages();
}
