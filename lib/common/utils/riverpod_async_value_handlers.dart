import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/widgets/errors/dio_exception_page.dart';

abstract class RiverpodAsyncValueHandlers {
  static Widget error(Object err, StackTrace stackTrace) {
    if (err is! DioException) {
      debugPrint('$err');

      return Center(child: Text('$err'));
    }

    return DioExceptionPage(exception: err);
  }

  static Widget loading() => const Center(child: CircularProgressIndicator());
}
