import 'package:equatable/equatable.dart';
import 'package:screen_pal_core/src/entities.dart';

abstract base class CreditsBase extends Equatable {
  const CreditsBase({required this.productId});

  /// [Movie]/[TvShow] id.
  final int productId;
  List<CreditPerson> get casts;
  List<CreditPerson> get crews;
}

final class Credits extends CreditsBase {
  @override
  final List<Cast> casts;

  @override
  final List<Crew> crews;

  const Credits({
    required super.productId,
    required this.casts,
    required this.crews,
  });

  @override
  List<Object> get props => [productId];
}

/// Include every episode of a TV show in the credits.
final class TvCredits extends CreditsBase {
  const TvCredits({
    required super.productId,
    required this.casts,
    required this.crews,
  });

  @override
  final List<TvCast> casts;

  @override
  final List<TvCrew> crews;

  @override
  List<Object?> get props => [productId];
}