// coverage:ignore-file

import 'package:get_it/get_it.dart';

import 'registry/registry.dart';

final locator = GetIt.instance;

Future<void> init() async {
  registerRepo();
  registerUseCases();
  await registerServices();
}
