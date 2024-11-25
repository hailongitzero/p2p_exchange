import "package:flutter/widgets.dart";
import "package:get/get.dart";
import "package:p2p_exchange/app/settings/languages/language.dart";

class LanguageController extends GetxController {
  final localizes = LocalString().keys;
  RxString language = 'English'.obs;
  final List<Map<String, dynamic>> localizations = [
    {
      'name': 'English',
      'locale': const Locale('en', 'US'),
    },
    {
      'name': 'Việt Nam',
      'locale': const Locale('vi', 'VN'),
    }
  ];
}
