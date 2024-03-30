import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/controller/input_controller.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/utils/text_style.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/view/widget/drawer.dart';

import '../model/filter_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final inputController = Get.put(InputController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text("app_title".tr),
        ),
        body: Obx(() => inputController.inputs.isEmpty
            ? Center(
                child: Text("no_expense_hint".tr),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Select Filters'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        inputController.filters.length,
                                        (index) => CheckboxListTile(
                                          title: Text(inputController
                                              .filters[index].title),
                                          value: inputController
                                              .filters[index].isSelected,
                                          onChanged: (value) {
                                            // inputController.toggleFilter(index, value ?? false);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  //   return Obx(() =>

                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        // Get selected filters
                                        List<FilterItem> selectedFilters =
                                            inputController.filters
                                                .where((filter) =>
                                                    filter.isSelected)
                                                .toList();
                                        // Do something with selected filters
                                        print(
                                            'Selected Filters: $selectedFilters');
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Apply Filters'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.sort_sharp)),
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
                                  motion: ScrollMotion(),
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
                                      // Update action (replace with your update logic)
                                      onPressed: (context) => {
                                        // inputController.updateInput(id, updatedInput)
                                      },
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Update',
                                    ),
                                  ],
                                ),
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
                                        "Date: ${DateFormat('yyyy-MM-dd').format(inputController.date.value)}",
                                      )
                                    ],
                                  ),
                                  //eachData.dateTime

                                  //${DateFormat('yyyy-MM-dd').format(inputController.date.value)}
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
