import 'dart:convert';

import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

  factory Genre.fromMap(Map<String, dynamic> json) {
    return Genre(id: json["id"], name: json["name"]);
  }

  @override
  List<Object> get props => [id, name];
}
