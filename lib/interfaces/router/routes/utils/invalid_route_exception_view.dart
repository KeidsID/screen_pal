import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/core/entities/errors/basic_http_exception.dart';
import 'package:screen_pal/interfaces/widgets.dart';

class InvalidRouteExceptionView extends StatelessWidget {
  const InvalidRouteExceptionView({
    super.key,
    this.message = 'Invalid route url',
    this.action,
  });

  final String message;

  /// Custom action for end-user.
  ///
  /// Typically an [ElevatedButton].
  final Widget? action;

  Widget get _defaultAction => Builder(
        builder: (context) => ElevatedButton.icon(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Go Back'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedExceptionWidget.expand(
        BasicHttpException(
          statusCode: 400,
          message: message,
        ),
        action: action ?? _defaultAction,
      ),
    );
  }
}
