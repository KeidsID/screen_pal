/// {@template screen_pal_core.entities.errors.BasicException}
/// Simple exception class for the app.
/// {@endtemplate}
class BasicException implements Exception {
  /// {@macro screen_pal_core.entities.errors.BasicException}
  const BasicException({
    this.name = 'Internal App Error',
    this.message = 'Sorry for the inconvenience',
  });

  final String name;
  final String message;
}
