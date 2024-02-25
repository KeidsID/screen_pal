import 'credits.dart';
import 'tv_full_cast.dart';
import 'tv_full_crew.dart';

/// Include every episode of a TV show in the credits.
final class TvFullCredits extends CreditsBase {
  const TvFullCredits({
    required this.productId,
    required this.casts,
    required this.crews,
  });

  /// [TvShow] id.
  @override
  final int productId;

  @override
  final List<TvFullCast> casts;

  @override
  final List<TvFullCrew> crews;

  @override
  List<Object?> get props => [productId];
}
