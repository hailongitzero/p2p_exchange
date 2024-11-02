// user_update_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/user_controller.dart';

class UserUpdatePage extends StatelessWidget {
  final UserController _controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final user = _controller.userModel.value;

          return ListView(
            children: [
              TextField(
                onChanged: _controller.setUsername,
                decoration: const InputDecoration(labelText: 'Username'),
                controller: TextEditingController(text: user.username),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: _controller.setBio,
                decoration: const InputDecoration(labelText: 'Bio'),
                controller: TextEditingController(text: user.bio),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text("Notification Preferences"),
                value: user.userSettings.notificationPreferences,
                onChanged: _controller.setNotificationPreferences,
              ),
              DropdownButtonFormField<String>(
                value: user.userSettings.theme,
                items: const [
                  DropdownMenuItem(value: "light", child: Text("Light")),
                  DropdownMenuItem(value: "dark", child: Text("Dark")),
                ],
                onChanged: _controller.setTheme,
                decoration: const InputDecoration(labelText: "Theme"),
              ),
              TextField(
                onChanged: _controller.setStreet,
                decoration: const InputDecoration(labelText: 'Street'),
                controller: TextEditingController(text: user.address.street),
              ),
              TextField(
                onChanged: _controller.setCity,
                decoration: const InputDecoration(labelText: 'City'),
                controller: TextEditingController(text: user.address.city),
              ),
              TextField(
                onChanged: _controller.setState,
                decoration: const InputDecoration(labelText: 'State'),
                controller: TextEditingController(text: user.address.state),
              ),
              TextField(
                onChanged: _controller.setZipCode,
                decoration: const InputDecoration(labelText: 'Zip Code'),
                controller: TextEditingController(text: user.address.zipCode),
              ),
              ElevatedButton(
                onPressed: _controller.updateUserData,
                child: const Text('Save Changes'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
