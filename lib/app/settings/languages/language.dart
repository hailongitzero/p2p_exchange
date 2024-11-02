import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {"hello": "Hello", "language": "Language"},
        "pt_PT": {"hello": "Hola", "language": "Idioma"}
      };
}