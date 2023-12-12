// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_response_exception.freezed.dart';
part 'common_response_exception.g.dart';

@freezed
class CommonResponseException with _$CommonResponseException {
  @Implements<Exception>()
  const factory CommonResponseException({
    required bool success,
    @JsonKey(name: 'status_code') required int statusCode,
    @JsonKey(name: 'status_message') required String statusMessage,
  }) = _CommonResponseException;

  factory CommonResponseException.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseExceptionFromJson(json);
}
