import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/localizations/language.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/routes.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/view/home.dart';

void main() async {
  await GetStorage.init();
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
