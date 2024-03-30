import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  var locale = 'en_us'.obs;

  void changeLocale(String newLocale) {
    locale.value = newLocale;
    Get.updateLocale(Locale(newLocale));
  }
}
