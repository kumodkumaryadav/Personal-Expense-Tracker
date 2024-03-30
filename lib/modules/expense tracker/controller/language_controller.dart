import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  final List<String> languages = [
    "English",
    "Hindi"
  ]; // List of languages to display
  RxString selectedLanguage = "English".obs; // Currently selected language
  var locale = 'en_us'.obs;

  void changeLocale(String setLange) {
    if (setLange == "English") {
      locale.value = "en_us";
    } else if (setLange == "Hindi") {
      locale.value = "hindi_in";
    }

    Get.updateLocale(Locale(locale.value));
  }
}
