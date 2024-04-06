import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/auth%20module/controllers/login_controller.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/colors/app_color.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/utils/text_style.dart';
import 'package:personal_expense_tracker/resources/image_constant.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Let's Login!",
                        style: TextStyleHelper.t25b700()
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                    SvgPicture.asset(
                      ImageConstant.loginImage,
                      height: 200,
                      width: 400,
                    ),
                    //  Image.asset("lib/resources/assets/images/login_image.jpeg"),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter password"),
                      onChanged: (password) {
                        loginController.inputUserModel.value.password =
                            password;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password!";
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    Obx(() => loginController.loading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginController.login();
                              }
                            },
                            child: SizedBox(
                                width: Get.width,
                                child:
                                    const Center(child: Text("Click Login"))))),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
