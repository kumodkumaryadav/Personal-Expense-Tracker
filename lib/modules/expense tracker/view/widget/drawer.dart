import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';

import '../../controller/language_controller.dart';

class MyDrawer extends StatelessWidget {
  final LocalizationController localizationController =
      Get.put(LocalizationController());

  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/user_photo.png'),
                  radius: 30,
                ),
                SizedBox(height: 10),
                Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              // Implement logout functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Change Theme'),
            onTap: () {
              // Implement theme change functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Change Language'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Select Language"),
                    content: LanguageDropdown(
                      onChanged: (value) {
                        // Handle language change here
                        localizationController.changeLocale(value);
                        Get.back();
                      },
                    ),
                  );
                },
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  final Function(String) onChanged; // Callback for language change

  LanguageDropdown({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final langController = Get.put(LocalizationController());
  @override
  Widget build(BuildContext context) {
    print("Lang tapped");
    return DropdownButton<String>(
      value: langController.selectedLanguage.value, // Currently selected value
      items: langController.languages
          .map((String language) => DropdownMenuItem<String>(
                value: language,
                child: Text(language),
              ))
          .toList(),
      onChanged: (String? newLanguage) {
        if (newLanguage != null) {
          onChanged(newLanguage); // Call callback with new language
        }
      },
      hint: const Text('Select Language'), // Placeholder text
    );
  }
}
