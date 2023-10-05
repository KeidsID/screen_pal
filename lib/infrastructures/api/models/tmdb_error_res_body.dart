// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_error_res_body.freezed.dart';
part 'tmdb_error_res_body.g.dart';

@freezed
class TmdbErrorResBody with _$TmdbErrorResBody {
  const factory TmdbErrorResBody({
    required bool success,
    @JsonKey(name: 'status_code') required int statusCode,
    @JsonKey(name: 'status_message') required String statusMessage,
  }) = _TmdbErrorResBody;

  factory TmdbErrorResBody.fromJson(Map<String, dynamic> json) =>
      _$TmdbErrorResBodyFromJson(json);
}
