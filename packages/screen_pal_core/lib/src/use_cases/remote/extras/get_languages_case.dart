import 'package:screen_pal_core/src/entities.dart';
import 'package:screen_pal_core/src/services.dart';

final class GetLanguagesCase {
  const GetLanguagesCase({required ExtrasRepo extrasRepo})
      : _extrasRepo = extrasRepo;

  final ExtrasRepo _extrasRepo;

  Future<List<SpokenLanguage>> execute() => _extrasRepo.getLanguages();
}
