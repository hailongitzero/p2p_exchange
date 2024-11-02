import "package:flutter/widgets.dart";
import "package:get/get.dart";
import "package:p2p_exchange/app/settings/languages/language.dart";

class LanguageController extends GetxController {
  final localizes = LocalString().keys;
  final List<Map<String, dynamic>> localizations = [
    {
      'name': 'English',
      'locale': const Locale('en', 'US'),
    },
    {
      'name': 'Portugal',
      'locale': const Locale('pt', 'PT'),
    }
  ];
}
