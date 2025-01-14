import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:newcustomerapp/src/my_app.dart';

import 'src/core/enum/box_types.dart';
import 'src/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetIt.instance.allReady();
  await setupLocator();
  if (Platform.isAndroid) {
    setOptimalDisplayMode();
  }
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1024 * 1024 * 300;
  final Box<dynamic> settings =
      locator.get<Box<dynamic>>(instanceName: BoxType.settings.name);

  runApp(NewCustomerApp(
    settings: settings,
  ));
}

Future<void> setOptimalDisplayMode() async {
  final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  final DisplayMode active = await FlutterDisplayMode.active;

  final List<DisplayMode> sameResolution = supported
      .where(
        (DisplayMode m) => m.width == active.width && m.height == active.height,
      )
      .toList()
    ..sort(
      (DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate),
    );

  final DisplayMode mostOptimalMode =
      sameResolution.isNotEmpty ? sameResolution.first : active;

  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}
