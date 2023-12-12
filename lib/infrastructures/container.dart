// coverage:ignore-file

/// {@template infrastructures.container}
/// A container package for dependency injection.
///
/// Call [init] before using the [locator].
/// ```
/// import 'package:screen_pal/infrastructures/container.dart' as container;
///
/// void main() async {
///   await container.init();
///
///   locator<InstanceType>(); // return object with the instance type.
/// }
/// ```
///
/// So make sure register all the dependencies in the
/// [lib/container/_res/](lib/container/_res/register_services.dart).
///
/// See [get_it](https://pub.dev/packages/get_it) package for more detail about
/// how it works.
/// {@endtemplate}
library container;

export 'container/container.dart';
