import 'package:equatable/equatable.dart';

import 'cast.dart';
import 'crew.dart';

class Credits extends Equatable {
  final int id;
  final List<Cast> casts;
  final List<Crew> crews;

  const Credits({
    required this.id,
    required this.casts,
    required this.crews,
  });

  @override
  List<Object> get props => [id, casts, crews];
}
