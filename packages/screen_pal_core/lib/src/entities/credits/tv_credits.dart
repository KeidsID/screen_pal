import 'package:screen_pal_core/src/entities.dart';

/// Include every episode of a TV show in the credits.
final class TvCredits extends CreditsBase {
  const TvCredits({
    required this.productId,
    required this.casts,
    required this.crews,
  });

  /// [TvShow] id.
  @override
  final int productId;

  @override
  final List<TvCast> casts;

  @override
  final List<TvCrew> crews;

  @override
  List<Object?> get props => [productId];
}
