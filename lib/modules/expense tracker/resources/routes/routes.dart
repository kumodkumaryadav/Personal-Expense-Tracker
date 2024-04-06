import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/auth%20module/views/login.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/view/expense.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/view/home.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/view/widget/filter_screen.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/view/widget/update_screen.dart';

import '../../view/widget/notification_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.loginScreen,
          page: () => LoginScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.homeScreen,
          page: () => HomePage(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.addExpenseScreen,
          page: () => InputScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.updateExpenseScreen,
          page: () => UpdateScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.filterScreen,
          page: () => FilterScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.notification,
          page: () => NotificationPage(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
      ];
}
