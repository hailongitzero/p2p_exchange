import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/screens/login/login.dart';
import 'package:p2p_exchange/app/settings/languages/language_controller.dart';
import 'package:p2p_exchange/app/settings/themes/theme.dart';

class SettingsPage extends StatelessWidget {
  final LanguageController languageController = Get.put(LanguageController());

  final RxBool isDarkMode = false.obs; // Reactive variable for theme

  SettingsPage({super.key});

  void _changePassword(BuildContext context) {
    // Handle change password logic
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Change Password'),
        content: const Column(
          children: [
            CupertinoTextField(
              placeholder: 'Current Password',
              obscureText: true,
            ),
            SizedBox(height: 8),
            CupertinoTextField(
              placeholder: 'New Password',
              obscureText: true,
            ),
            SizedBox(height: 8),
            CupertinoTextField(
              placeholder: 'Confirm New Password',
              obscureText: true,
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: const Text('Save'),
            onPressed: () {
              // Save new password logic
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('settings'.tr),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),

            // Theme Setting with Obx
            Obx(() {
              return CupertinoListTile(
                title: Text(
                  'Dark Mode',
                  style: textTheme
                      .copyWith(
                          titleLarge: textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold))
                      .titleSmall,
                ),
                trailing: CupertinoSwitch(
                  value: isDarkMode.value,
                  onChanged: (value) {
                    Get.changeThemeMode(
                        isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
                    isDarkMode.value = value;
                    // Handle theme change logic if necessary
                  },
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              );
            }),
            const Divider(),

            // Language Setting with Obx
            Obx(() {
              return CupertinoListTile(
                title: Text(
                  'Language',
                  style: textTheme
                      .copyWith(
                          titleLarge: textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold))
                      .titleSmall,
                ),
                trailing: CupertinoButton(
                  child: Text(languageController.language.value),
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: Text('selectLanguage'.tr),
                        actions:
                            languageController.localizations.map((language) {
                          return CupertinoActionSheetAction(
                            child: Text(language['name']),
                            onPressed: () {
                              var lag = language['name'];
                              languageController.language.value =
                                  language['name'];
                              Get.updateLocale(language['locale']);
                            },
                          );
                        }).toList(),
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  },
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              );
            }),
            const Divider(),

            // Change Password Setting
            CupertinoListTile(
              title: Text(
                'changePassword'.tr,
                style: textTheme
                    .copyWith(
                        titleLarge: textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.bold))
                    .titleSmall,
              ),
              trailing: CupertinoButton(
                onPressed: () => _changePassword(context),
                child: Text('change'.tr),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            const Divider(),

            CupertinoListTile(
              title: Text(
                'logOut'.tr,
                style: textTheme
                    .copyWith(
                        titleLarge: textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.bold))
                    .titleSmall,
              ),
              trailing: CupertinoButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Text('signOut'.tr),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

// CupertinoListTile for consistency with iOS-style design
class CupertinoListTile extends StatelessWidget {
  final Widget title;
  final Widget trailing;
  final EdgeInsetsGeometry? padding;

  const CupertinoListTile({
    super.key,
    required this.title,
    required this.trailing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: title),
          trailing,
        ],
      ),
    );
  }
}
