// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:personal_expense_tracker/modules/auth%20module/models/token_model.dart';
import 'package:personal_expense_tracker/modules/auth%20module/services/auth_service.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/localizations/language.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/routes.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/services/notification_services.dart';
import 'package:timezone/data/latest.dart' as tz;

final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  final AuthServices authServices = AuthServices();
  Tokens tokens = await authServices.getTokenFromStoarge();
  // Configure initialization settings
  await GetStorage.init();
  tz.initializeTimeZones();
  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (initialNotification?.didNotificationLaunchApp == true) {
    Future.delayed(const Duration(seconds: 1), () {
      print("back button response");
      Get.toNamed(RouteName.addExpenseScreen);
    });
  }

  runApp(MyApp(
    tokens: tokens,
  ));
}

class MyApp extends StatelessWidget {
  final Tokens tokens;
  MyApp({
    Key? key,
    required this.tokens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: tokens.token.isNotEmpty
          ? RouteName.homeScreen
          : RouteName.loginScreen,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
      translations: Languages(),
      locale: const Locale("en_us", "hindi_in"),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
      builder: EasyLoading.init(),
      
      // home: HomePage(),//it was causing error
    );
  }
}
