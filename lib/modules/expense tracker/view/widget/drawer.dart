import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/auth%20module/controllers/login_controller.dart';
import 'package:personal_expense_tracker/modules/auth%20module/services/auth_service.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/controller/input_controller.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/services/local%20storage/experse_storage.dart';
import 'package:personal_expense_tracker/resources/app_constant.dart';

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
                    "https://media.licdn.com/dms/image/D4D03AQHKwnVnD-dZGA/profile-displayphoto-shrink_200_200/0/1680599426255?e=2147483647&v=beta&t=K6K7NwdFxwueKEkXjFZUz_NoTEdXJP0Rj_8FHAaSzCs",
                  ),
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
                showDialog(
                  context: context,
                  builder: (context) {
                    return LogoutDialog(onLogoutPressed: () {
                      loginController.logOut();
                    });
                    // Implement logout functionality
                  },
                );
              }),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Change Theme'),
            onTap: () {
              // final StorageServices authServices1 = StorageServices();
              // final StorageServices authServices2 = StorageServices();
              final InputController inputController1 = (InputController());
              final InputController inputController2 = (InputController());
              print(
                  "Instance are same ${identical(inputController1, inputController2)}");
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

class LogoutDialog extends StatelessWidget {
  final Function onLogoutPressed;

  LogoutDialog({required this.onLogoutPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Are you sure you want to logout? Saved data will be deleted.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      onLogoutPressed();
                      Get.back(); // Close the dialog
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
