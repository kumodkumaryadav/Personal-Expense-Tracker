// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/controller/input_controller.dart';

import '../resources/routes/route_name.dart';
import '../services/notification_services.dart';
class NotificationController extends GetxController {
  final box = GetStorage();
  final inputController = Get.find<InputController>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance!.addObserver(AppLifecycleObserver(controller: this));
  }

  @override
  void onClose() {
    WidgetsBinding.instance!.removeObserver(AppLifecycleObserver(controller: this));
    super.onClose();
  }

  void showScheduleNotification() {
    print("No today entry available");
    LocalNotifications.showScheduleNotification(
      title: "Did you add today's expenses",
      body: "Tap to add today's expense",
      payload: "This is schedule data",
      dateTime: DateTime.now().add(const Duration(seconds: 60)), // Show notification after 1 minute
    );
  }

  void checkAndScheduleNotification() {
    bool hasTodayEntry = inputController.inputs.any((element) =>
        DateTime(element.dateTime.year, element.dateTime.month, element.dateTime.day) ==
        DateTime.now());

    if (!hasTodayEntry) {
      showScheduleNotification();
      box.write("lastNotificationShown", DateTime.now().millisecondsSinceEpoch);
    }
  }
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  final NotificationController controller;

  AppLifecycleObserver({required this.controller});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.checkAndScheduleNotification();
    }
  }
}

