import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationController extends GetxController {
  final List<String> languages = [
    "English",
    "Hindi"
  ]; // List of languages to display
  RxString selectedLanguage = "English".obs; // Currently selected language
  var locale = ''.obs;

  final box = GetStorage();

  @override
  void onInit() {
    locale.value = box.read('lan') ?? "en_us";
    changeLocale(locale.value);

    super.onInit();
  }

  void changeLocale(String setLange) {
    box.write('lan', setLange);

    if (setLange == "English") {
      locale.value = "en_us";
    } else if (setLange == "Hindi") {
      locale.value = "hindi_in";
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.updateLocale(Locale(locale.value));
    });
  }
}
