// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/widgets/errors/dio_exception_widget.dart';

abstract class RiverpodAsyncValueHandlers {
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

    if (error is! DioException) {
      debugPrint('$error');

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Internal App Error'),
            const Divider(),
            const Text('Sorry for the inconvenience'),
            const SizedBox(height: 16.0),
            actionButton,
          ],
        ),
      );
    }

    return DioExceptionWidget(exception: error, action: actionButton);
  }

  static Widget loading() => const Center(child: CircularProgressIndicator());
}
