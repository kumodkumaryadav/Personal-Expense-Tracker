import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/auth%20module/controllers/login_controller.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/colors/app_color.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/utils/text_style.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          title: Text(
            "Login Screen",
            style: TextStyleHelper.t16b700()
                .copyWith(fontSize: 28, color: AppColor.whiteColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Center(
                    child: Text("Login to Continue"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter user id",
                    ),
                    onChanged: (useId) {
                      loginController.inputUserModel.value.userId = useId;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter userId";
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Enter password"),
                    onChanged: (password) {
                      loginController.inputUserModel.value.password = password;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password!";
                      }
                    },
                  ),
                  const Spacer(),
                  Obx(() => loginController.loading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              loginController.login();
                            }
                          },
                          child: const Text("Click Login"))),
                  const SizedBox(
                    height: 30,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
