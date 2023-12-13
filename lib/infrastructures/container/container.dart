// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:screen_pal/core/services.dart';
import 'package:screen_pal/core/use_cases.dart';
import 'package:screen_pal/infrastructures/services/services.dart';
import 'package:screen_pal/infrastructures/tmdb/client/client.dart';

part '_res/register_services.dart';
part '_res/register_use_cases.dart';

/// {@macro infrastructures.container}
final locator = GetIt.instance;

/// {@macro infrastructures.container}
Future<void> init() async {
  _registerServices();
  _registerUseCases();

  await locator.allReady();
}
