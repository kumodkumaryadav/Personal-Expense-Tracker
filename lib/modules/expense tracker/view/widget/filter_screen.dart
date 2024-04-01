import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/controller/input_controller.dart';


class FilterScreen extends StatelessWidget {
  final InputController inputController = Get.put(InputController());

  FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              inputController.applyFilters();
            },
          ),
        ],
      ),
      body: GetBuilder<InputController>(
        builder: (controller) {
          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
