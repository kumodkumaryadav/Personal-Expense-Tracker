import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/controller/input_controller.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/colors/app_color.dart';

class FilterScreen extends StatelessWidget {
  final InputController inputController = Get.put(InputController());

  FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.whiteColor,
              )),
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
          title: const Text(
            'Apply Filters',
            style: TextStyle(color: AppColor.whiteColor),
          ),
        ),
        body: Column(
          children: [
            GetBuilder<InputController>(
              builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.filters.length,
                    itemBuilder: (context, index) {
                      final filter = controller.filters[index];
                      return Obx(() => CheckboxListTile(
                            title: Text(filter),
                            value: controller.selectedFilters.contains(filter),
                            onChanged: (value) {
                              controller.toggleFilter(filter);
                            },
                          ));
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  inputController.filterAndApply();
                },
                child: const Text("APPLY FILTER")),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
