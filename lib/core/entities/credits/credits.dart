import 'package:equatable/equatable.dart';

import '../movies/movie.dart';
import '../tv_shows/tv_show.dart';
import 'cast.dart';
import 'crew.dart';
import 'credit_person.dart';

abstract base class CreditsBase extends Equatable {
  const CreditsBase();

  /// [Movie]/[TvShow] id.
  int get productId;
  List<CreditPerson> get casts;
  List<CreditPerson> get crews;
}

final class Credits extends CreditsBase {
  @override
  final int productId;

  @override
  final List<Cast> casts;

  @override
  final List<Crew> crews;

  const Credits({
    required this.productId,
    required this.casts,
    required this.crews,
  });

  @override
  List<Object> get props => [productId];
}
