import 'package:screen_pal/core/entities/extras/spoken_language.dart';
import 'package:screen_pal/core/repo/extras_repo.dart';

class GetLanguages {
  final ExtrasRepo extrasRepo;

  GetLanguages({required this.extrasRepo});

  Future<List<SpokenLanguage>> execute() => extrasRepo.getLanguages();
}
