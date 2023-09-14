// coverage:igore-file

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const Map<int, String> _clientErrRes = {
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

/// A widget that displays [DioException] info in a simple way.
class DioExceptionWidget extends StatelessWidget {
  /// Create a [DioExceptionWidget] that displays [DioException] info in a
  /// simple way.
  const DioExceptionWidget({super.key, required this.exception, this.action});

  final DioException exception;

  /// Add widget on the bottom. Typically an [ElevatedButton].
  ///
  /// If null, then no [action] widget rendered on the bottom.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (exception.type != DioExceptionType.badResponse) {
      debugPrint(exception.message);

      return _layout(children: [
        const Text('Internal App Error'),
        const Divider(),
        const Text('Sorry for the inconvenience'),
      ]);
    }

    final response = exception.response!;
    final statusCode = response.statusCode ?? 0;

    debugPrint(response.data);

    return _layout(children: [
      Text('$statusCode', style: textTheme.displayMedium),
      Text(
        {..._clientErrRes, ..._serverErrRes}[statusCode] ??
            'Internal App Error',
        style: textTheme.headlineSmall,
      ),
      const Divider(),
      const Text('Sorry for the inconvenience'),
    ]);
  }

  Widget _layout({List<Widget> children = const <Widget>[]}) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...children,
          const SizedBox(height: 16.0),
          action ?? const SizedBox(),
        ],
      ),
    );
  }
}
