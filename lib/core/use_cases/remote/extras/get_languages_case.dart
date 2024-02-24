import 'package:screen_pal/core/entities/extras/spoken_language.dart';
import 'package:screen_pal/core/services/remote/extras_repo.dart';

final class GetLanguagesCase {
  const GetLanguagesCase({required ExtrasRepo extrasRepo})
      : _extrasRepo = extrasRepo;

  final ExtrasRepo _extrasRepo;

  Future<List<SpokenLanguage>> execute() => _extrasRepo.getLanguages();
}
