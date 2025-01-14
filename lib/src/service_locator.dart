import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/enum/box_types.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await _setupHive();
}

Future<void> _setupHive() async {
  await Hive.initFlutter();
  final boxDynamic = await Hive.openBox(BoxType.settings.name);
  locator.registerLazySingleton<Box<dynamic>>(() => boxDynamic,
      instanceName: BoxType.settings.name);

  final boxCache = await Hive.openBox(BoxType.cache.name);
  locator.registerLazySingleton<Box<dynamic>>(() => boxCache,
      instanceName: BoxType.cache.name);

  final boxAccount = await Hive.openBox(BoxType.account.name);
  locator.registerLazySingleton<Box<dynamic>>(() => boxAccount,
      instanceName: BoxType.account.name);
}
