import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/auth%20module/models/input_model.dart';
import 'package:personal_expense_tracker/modules/auth%20module/models/token_model.dart';
import 'package:personal_expense_tracker/modules/auth%20module/services/auth_service.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/controller/input_controller.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/colors/app_color.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';
import 'package:personal_expense_tracker/resources/api_helper.dart';
import 'package:personal_expense_tracker/resources/dio_client.dart';

class LoginController extends GetxController {
  Rx<InputUserModel> inputUserModel = InputUserModel.empty().obs;
  final ApiService apiService = ApiService();
  final AuthServices authServices = AuthServices();
  final inputController = Get.put(InputController());
  RxBool loading = false.obs;
  setLoading(bool load) {
    loading.value = load;
  }

  logOut() async {
    await authServices.deleteTokens();
    await inputController.deleteDataFromStorage();
    Get.offAllNamed(RouteName.loginScreen);
    Get.snackbar("Log out!", "Successfully logged out and all entry deleted",
        backgroundColor: AppColor.redColor, colorText: AppColor.whiteColor);
  }

  checkAuthentication() async {
    Tokens token = await authServices.getTokenFromStoarge();
    if (token.token.isEmpty) {
      Get.offAllNamed(RouteName.loginScreen);
    }
  }

  login() async {
    setLoading(true);
    Map<String, dynamic> data = {
      'email': inputUserModel.value.userId.trim(),
      'password': inputUserModel.value.password.trim()
    };
    try {
      var resp = await apiService.post(ApiHepler.loginEp, data: data);
      Tokens tokens = Tokens.fromJson(resp);
      await authServices.storeToken(tokens);
      Get.snackbar("Login success", "You are successfully logged in!",
          backgroundColor: AppColor.primaryButtonColor,
          colorText: AppColor.whiteColor);
      Get.offAllNamed(RouteName.homeScreen);
    } catch (e) {
      print("error occured");
      if (e is CustomDioExceptions) {
        Get.snackbar("Login failed!", e.message!.toString(),
            backgroundColor: AppColor.redColor, colorText: AppColor.whiteColor);
      }
      if (e is DioError) {
        print("$e");

        Get.snackbar("Login failed!", e.message!.toString(),
            backgroundColor: AppColor.redColor, colorText: AppColor.whiteColor);
      }
    } finally {
      setLoading(false);
    }
  }
}
