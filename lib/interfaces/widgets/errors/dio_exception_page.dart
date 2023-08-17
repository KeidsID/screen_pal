import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioExceptionPage extends StatelessWidget {
  const DioExceptionPage({super.key, required this.exception});

  final DioException exception;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${exception.response?.statusCode! ?? ''}',
            style: textTheme.displayMedium,
          ),
          Text(
            exception.response?.statusMessage! ?? 'Network Not Available',
            style: textTheme.headlineSmall,
          ),
          const Divider(),
          const Text('Sorry for the inconvenience'),
        ],
      ),
    );
  }
}
