import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/settings/languages/language_controller.dart';

void changeLanguageApp() {
  final LanguageController _controller = LanguageController();
  Get.dialog(AlertDialog(
    title: Text('language'.tr),
    content: SizedBox(
      width: double.infinity,
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // final languageName = _controller.localizations[index]['name'];
            final languageCode = _controller.localizations[index]['locale'];
            return InkWell(
              child: Text('language'.tr),
              onTap: () {
                Get.back();
                Get.updateLocale(languageCode);
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: _controller.localizes.length),
    ),
  ));
}
