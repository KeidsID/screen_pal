import 'dart:convert';

import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  const Collection({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory Collection.fromJson(String str) {
    return Collection.fromMap(jsonDecode(str));
  }

  factory Collection.fromMap(Map<String, dynamic> json) {
    return Collection(
      id: json["id"],
      name: json["name"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
    );
  }

  @override
  List<Object?> get props => [id, name, posterPath, backdropPath];
}
