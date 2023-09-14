// coverage:ignore-file

import 'package:get_it/get_it.dart';

import 'registry/registry.dart' as registry;

final locator = GetIt.instance;

Future<void> init() async {
  registry.registerRepo();
  registry.registerUseCases();
  await registry.registerServices();
}
