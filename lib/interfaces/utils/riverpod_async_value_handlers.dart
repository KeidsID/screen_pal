// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/configs/constants.dart';
import 'package:screen_pal/interfaces/widgets/errors/dio_exception_widget.dart';
import 'package:screen_pal/interfaces/widgets/errors/unknown_error_widget.dart';

abstract final class RiverpodAsyncValueHandlers {
  /// [action] used to add refresh provider action.
  ///
  /// If null, then no action button will rendered.
  static Widget error(
    Object error,
    StackTrace stackTrace, {
    VoidCallback? action,
  }) {
    final actionButton = action != null
        ? ElevatedButton.icon(
            onPressed: action,
            icon: const Icon(Icons.refresh_outlined),
            label: const Text('Refresh'),
          )
        : const SizedBox();

    if (error is DioException) {
      return DioExceptionWidget(error, action: actionButton);
    }

    kLogger.f('RiverpodAsyncValueHandlers.error', error: error);

    return UnknownErrorWidget(action: actionButton);
  }

  static Widget loading() => const Center(child: CircularProgressIndicator());
}
