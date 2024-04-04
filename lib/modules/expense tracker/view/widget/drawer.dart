import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/auth%20module/controllers/login_controller.dart';
import 'package:personal_expense_tracker/respurces/app_constant.dart';

import '../../controller/language_controller.dart';

class MyDrawer extends StatelessWidget {
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  final loginController = Get.put(LoginController());

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
                  backgroundImage: NetworkImage(
                      "https://media.licdn.com/dms/image/D4D03AQHKwnVnD-dZGA/profile-displayphoto-shrink_200_200/0/1680599426255?e=2147483647&v=beta&t=K6K7NwdFxwueKEkXjFZUz_NoTEdXJP0Rj_8FHAaSzCs"),
                  radius: 30,
                ),
                SizedBox(height: 10),
                Text(
                  'Kumod Yadav',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'kumod353@gmail.com',
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
              loginController.logOut();
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
            subtitle: Text(AppConstant.appVersion),
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
