import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/localizations/language.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/routes.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/services/notification_services.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/view/home.dart';

import 'package:timezone/data/latest.dart' as tz;

final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  // Configure initialization settings
  await GetStorage.init();
  tz.initializeTimeZones();
  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (initialNotification?.didNotificationLaunchApp == true) {
    Future.delayed(const Duration(seconds: 1), () {
      Get.toNamed(RouteName.addExpenseScreen);
       });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
      translations: Languages(),
      locale: const Locale("en_us", "hindi_in"),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
