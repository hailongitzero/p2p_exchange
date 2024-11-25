import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/screens/splash/splash.dart';
import 'package:p2p_exchange/app/settings/languages/language.dart';
import 'package:p2p_exchange/app/settings/themes/theme.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _AppState();
}

class _AppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.system;
  Brightness brightMode = Brightness.light;

  bool get useLightMode => switch (themeMode) {
        ThemeMode.system =>
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false
      };

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
      brightMode = useLightMode ? Brightness.light : Brightness.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      title: 'hello'.tr,
      themeMode: ThemeMode.system,
      theme: ThemeApp.light,
      darkTheme: ThemeApp.dart,
      builder: (context, child) {
        return CupertinoTheme(
          // Instead of letting Cupertino widgets auto-adapt to the Material
          // theme (which is green), this app will use a different theme
          // for Cupertino (which is blue by default).
          data: const CupertinoThemeData(),
          child: Material(child: child),
        );
      },
      home: const SplashScreen(),
    );
  }
}
