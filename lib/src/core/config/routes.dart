import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newcustomerapp/src/core/constants/route_constants.dart';
import 'package:newcustomerapp/src/core/enum/box_types.dart';
import 'package:newcustomerapp/src/my_app.dart';

final settings = Hive.box(BoxType.settings.name);
final account = Hive.box(BoxType.account.name);
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: homePagePath,
    errorBuilder: (context, state) => Center(
          child: Text(state.error.toString()),
        ),
    observers: [HeroController()],
    // refreshListenable: settings.listenable(),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: homePagePath,
        builder: (context, state) => MyHomePage(
          title: 'New Flutter App',
        ),
      ),
    ]);
