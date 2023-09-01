// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/widgets/errors/dio_exception_widget.dart';

abstract class RiverpodAsyncValueHandlers {
  static Widget error(Object error, StackTrace stackTrace) {
    if (error is! DioException) {
      debugPrint('$error');

      return Center(child: Text('$error'));
    }

    return DioExceptionWidget(exception: error);
  }

  static Widget loading() => const Center(child: CircularProgressIndicator());
}
