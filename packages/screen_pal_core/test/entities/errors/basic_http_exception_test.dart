import 'package:flutter_test/flutter_test.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

const commonErrorResponses = <int, String>{
  400: 'Bad Request',
  401: 'Unauthorized',
  403: 'Forbidden',
  404: 'Not Found',
  500: 'Internal Server Error',
};

void main() {
  test(
    'BasicHttpException.name - should return the name of the HTTP error status code',
    () {
      // testing common error codes
      expect(
        BasicHttpException(statusCode: 400).name,
        commonErrorResponses[400],
      );
      expect(
        BasicHttpException(statusCode: 401).name,
        commonErrorResponses[401],
      );
      expect(
        BasicHttpException(statusCode: 403).name,
        commonErrorResponses[403],
      );
      expect(
        BasicHttpException(statusCode: 404).name,
        commonErrorResponses[404],
      );
      expect(
        BasicHttpException(statusCode: 500).name,
        commonErrorResponses[500],
      );

      //
      expect(
        BasicHttpException(statusCode: 999).name,
        'Internal App Error',
      );
    },
  );

  test(
    'BasicHttpException.statusCode - should return null if not an HTTP error status code',
    () {
      expect(
        BasicHttpException(statusCode: 999).statusCode,
        null,
      );
      expect(
        BasicHttpException(statusCode: 081).statusCode,
        null,
      );

      // Valid HTTP status codes, but not the error one.
      expect(
        BasicHttpException(statusCode: 200).statusCode,
        null,
      );
    },
  );
}
