import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remitance/src/common/constants/keys.dart';
import 'package:remitance/src/core/theme/theme.dart';

import '../../core/routes/app_pages.dart';

class TestApp extends StatefulWidget {
  final Box<dynamic> settings;
  const TestApp({super.key, required this.settings});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  late StreamSubscription _lifecycleSubscription;

  @override
  void initState() {
    super.initState();

    _lifecycleSubscription = Stream.empty().listen((_) {});
  }

  @override
  void dispose() {
    _lifecycleSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: widget.settings.listenable(
        keys: [themeModeKey, appLanguageKey],
      ),
      builder: (context, value, _) {
        final ThemeMode themeMode = ThemeMode.values[value.get(
          themeModeKey,
          defaultValue: 1,
        )];
        final Locale locale =
            Locale(value.get(appLanguageKey, defaultValue: 'en'));
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale,
            themeMode: themeMode,
            theme: purpleTheme,
            darkTheme: purpleDarkTheme,
            initialRoute: AppRoutes.login,
            getPages: AppPages.pages,
          ),
        );
      },
    );
  }
}
