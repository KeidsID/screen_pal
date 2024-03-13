import 'package:equatable/equatable.dart';
import 'package:screen_pal_core/src/entities.dart';

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
