import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';
import 'package:uuid/uuid.dart';

import '../model/input_model.dart';
import '../resources/colors/app_color.dart';

class InputController extends GetxController {
  RxDouble amount = 0.0.obs;
  Rx<DateTime> date = DateTime.now().obs;
  RxString updateDate = "".obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  var isLoading = false.obs;
  RxList<InputModel> inputs = <InputModel>[].obs;
  RxList<InputModel> tempInput = <InputModel>[].obs;
  @override
  void onInit() {
    print("this is printed");
    tempInput = inputs;
    super.onInit();
    loadData();
  }

  //local storage
  final box = GetStorage();

  // Method to save data to storage
  void saveData() {
    final List<Map<String, dynamic>> dataToStore = inputs.map((input) {
      return input.toJson(); // Use toJson method
    }).toList();
    box.write('inputs', dataToStore);
  }

  // Method to load data from storage
  void loadData() {
    dynamic storedData = box.read('inputs') ?? "";
    if (storedData != null && storedData is List<dynamic>) {
      inputs.assignAll(storedData.map((data) {
        if (data is Map<String, dynamic>) {
          return InputModel.fromJson(data); // Use fromJson method
        } else {
          return InputModel(
              id: '',
              title: '',
              amount: 0.0,
              dateTime: DateTime.now(),
              description: '');
        }
      }).toList());
    } else {
      // Handle missing or invalid stored data
    }
  }

  final uuid = const Uuid();
//filter expense

  final filters = ['Title A-Z', 'Amount < 500', 'Amount > 200'].obs;

  final selectedFilters = <String>{}.obs;

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  void applyFilters() {
    if (kDebugMode) {
      print('Selected filters: $selectedFilters');
    }
    filterAndApply();
  }

  void addInput(InputModel input) {
    if (isInputModelNotEmpty(input)) {
      isLoading.value = true;
      inputs.add(input);
      saveData(); // Save data after adding a new input
      Future.delayed(const Duration(seconds: 2), () {
        Get.toNamed(RouteName.homeScreen, preventDuplicates: false);
        isLoading.value = false;
        Get.snackbar('Submitted',
            'Amount: ${input.amount}, Date: ${DateFormat('yyyy-MM-dd').format(input.dateTime)}, Description: ${input.description}',
            backgroundColor: AppColor.primaryColor);

        // Prints after 1 second.
      });

      //for showing loading purpose
    } else {
      Get.snackbar("Missing fields", "Each field is mandetory",
          backgroundColor: AppColor.redColor);
    }
  }

  bool isInputModelNotEmpty(InputModel input) {
    // Check if any of the properties are not empty
    return input.id.isNotEmpty &&
        input.title.isNotEmpty &&
        input.description.isNotEmpty &&
        input.amount != -1.0;
  }

  void updateInput(int index, String id, InputModel updatedInput) {
    isLoading.value = true;

    if (hasDataChanged(inputs[index], updatedInput)) {
      inputs[index] = updatedInput;
      saveData();
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(RouteName.homeScreen);
        isLoading.value = false;
        Get.snackbar('Entry updated', 'Sucessfully updated',
            backgroundColor: Colors.amber);

        // Prints after 1 second.
      });
    } else {
      isLoading.value = false;
      Get.offAllNamed(RouteName.homeScreen);
      Get.snackbar('Nothing to update', 'none the entry changed.',
          backgroundColor: Colors.green);
    }
  }

  //prevent unneccessary update
  bool hasDataChanged(InputModel oldInput, InputModel newInput) {
    return oldInput.id != newInput.id ||
        oldInput.title != newInput.title ||
        oldInput.amount != newInput.amount ||
        oldInput.dateTime != newInput.dateTime ||
        oldInput.description != newInput.description;
  }

  void deleteInput(String id) {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      inputs.removeWhere((input) => input.id == id);
      saveData();
      isLoading.value = false;
    });
  }

  void filterAndApply() {
    loadData();

    if (selectedFilters.isNotEmpty) {
      for (var element in selectedFilters) {
        if (element.contains("Title A-Z")) {
          inputs.sort((a, b) => a.title.compareTo(b.title));
        }
        if (element.contains("< 500")) {
          inputs.removeWhere((input) => input.amount >= 500);
        }
        if (element.contains("> 200")) {
          inputs.removeWhere((input) => input.amount <= 200);
        }
      }
      Get.back();
    } else {
      loadData();

      print("reset value");
      Get.back();
    }
  }

  void resetFilters() {
    // inputs.assignAll(originalInputs); // Restore original inputs list
    // Clear any applied filters
    selectedFilters.clear();
  }

  void sortByDateTime() {
    inputs.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  void sortById() {
    inputs.sort((a, b) => a.id.compareTo(b.id));
  }
}
