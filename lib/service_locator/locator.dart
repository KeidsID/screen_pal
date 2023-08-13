import 'package:get_it/get_it.dart';

import 'registry/registry.dart';

final locator = GetIt.instance;

void init() {
  registerRepo();
  registerUseCases();
}
