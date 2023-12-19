import 'package:equatable/equatable.dart';

import 'package:screen_pal/core/entities/credits/tv_full_cast.dart';
import 'package:screen_pal/core/entities/credits/tv_full_crew.dart';

class TvFullCredits extends Equatable {
  const TvFullCredits({
    required this.tvShowId,
    required this.casts,
    required this.crews,
  });

  final int tvShowId;
  final List<TvFullCast> casts;
  final List<TvFullCrew> crews;

  @override
  List<Object?> get props => [tvShowId];
}
