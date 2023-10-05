import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:screen_pal/interfaces/widgets/errors/app_error_widget.dart';
import 'package:screen_pal/interfaces/widgets/errors/dio_exception_widget.dart';

const _clientErrRes = {
  400: 'Bad Request',
  401: 'Unauthorized',
  403: 'Forbidden',
  404: 'Not Found',
  405: 'Method Not Allowed',
  406: 'Not Acceptable',
  407: 'Proxy Authentication Required',
  408: 'Request Timeout',
  409: 'Conflict',
  410: 'Gone',
  411: 'Length Required',
  412: 'Precondition Failed',
  413: 'Payload Too Large',
  414: 'URI Too Long',
  415: 'Unsupported Media Type',
  416: 'Range Not Satisfiable',
  417: 'Expectation Failed',
  418: "I'm a teapot",
  421: 'Misdirected Request',
  422: 'Unprocessable Content',
  423: 'Locked',
  424: 'Failed Dependency',
  426: 'Upgrade Required',
  428: 'Precondition Required',
  429: 'Too Many Requests',
  431: 'Request Header Fields Too Large',
  451: 'Unavailable For Legal Reasons',
};

const _serverErrRes = {
  500: 'Internal Server Error',
  501: 'Not Implemented',
  502: 'Bad Gateway',
  503: 'Service Unavailable',
  504: 'Gateway Timeout',
  505: 'HTTP Version Not Supported',
  506: 'Variant Also Negotiates',
  507: 'Insufficient Storage',
  508: 'Loop Detected',
  510: 'Not Extended',
  511: 'Network Authentication Required',
};

class AppHttpErrorWidget extends StatelessWidget {
  /// Create a widget to display brief info about the HTTP error that occurred.
  /// Is actually same as [AppErrorWidget] but with aditional [statusCode] that
  /// displayed above the [AppErrorWidget.title].
  ///
  /// If [statusCode] are invalid, [AppErrorWidget] will be rendered instead.
  ///
  /// See also:
  ///
  ///  * [AppErrorWidget], a widget to display brief info about the error that
  ///    occurred.
  ///  * [DioExceptionWidget], a widget to display brief info about the
  ///    [DioException] that provided.
  const AppHttpErrorWidget({
    super.key,
    required this.statusCode,
    this.message = 'Sorry for the inconvenience',
    this.padding,
    this.action,
  });

  /// The HTTP error status code.
  final int statusCode;

  /// Aditional message for error details.
  final String message;

  final EdgeInsetsGeometry? padding;

  /// Add widget on the bottom. Typically an [ElevatedButton].
  ///
  /// If null, then no [action] widget rendered on the bottom.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String? title = {..._clientErrRes, ..._serverErrRes}[statusCode];

    if (title == null) {
      return AppErrorWidget(message: message, padding: padding, action: action);
    }

    return SizedBox.expand(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$statusCode', style: theme.textTheme.displayMedium),
            Text(title, style: theme.textTheme.headlineSmall),
            const Divider(),
            Text(message),
            const SizedBox(height: 16.0),
            action ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
