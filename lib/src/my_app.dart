import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newcustomerapp/src/core/constants/keys.dart';
import 'package:newcustomerapp/src/core/theme/theme.dart';

import 'core/config/routes.dart';

class NewCustomerApp extends StatefulWidget {
  final Box<dynamic> settings;
  const NewCustomerApp({super.key, required this.settings});

  @override
  State<NewCustomerApp> createState() => _NewCustomerAppState();
}

class _NewCustomerAppState extends State<NewCustomerApp> {
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
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: locale,
          themeMode: themeMode,
          theme: light_theme,
          darkTheme: dark_theme,
          routerConfig: goRouter,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
