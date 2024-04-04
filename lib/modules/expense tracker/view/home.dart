import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/controller/input_controller.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/controller/notification_controller.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/colors/app_color.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/utils/text_style.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/view/widget/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final inputController = Get.put(InputController());
  final notificationController = Get.put(NotificationController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text("app_title".tr),
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAllNamed(RouteName.notification);
                },
                icon: const Icon(Icons.notifications))
          ],
        ),
        body: Obx(() => inputController.inputs.isEmpty
            ? Center(
                child: Text("no_expense_hint".tr),

                //in this way multi language can be done to intire app
                //I am not going to do it for intire app. It is as per business need
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search)),
                      IconButton(
                          onPressed: () {
                            Get.toNamed(RouteName.filterScreen,
                                preventDuplicates: false);
                          },
                          icon: const Icon(Icons.sort_sharp)),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: inputController.inputs.length,
                          itemBuilder: (context, index) {
                            var eachData = inputController.inputs[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      // Delete action
                                      onPressed: (context) => {
                                        inputController.deleteInput(eachData.id)
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      // Update action
                                      onPressed: (context) => {
                                        Get.toNamed(
                                            RouteName.updateExpenseScreen,
                                            arguments: {
                                              'index': index,
                                              'stringId': eachData.id
                                            })
                                      },
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Update',
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black12),
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          eachData.title,
                                          style: TextStyleHelper.t16b700(),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "Amount: \$${eachData.amount.toString()}",
                                          style: TextStyleHelper.t16b700(),
                                        )
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            eachData.description,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          "Date: ${DateFormat('yyyy-MM-dd').format(eachData.dateTime)}",
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RouteName.addExpenseScreen);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
