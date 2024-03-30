import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';
import 'package:uuid/uuid.dart';

import '../model/filter_model.dart';
import '../model/input_model.dart';

class InputController extends GetxController {
  RxDouble amount = 0.0.obs;
  Rx<DateTime> date = DateTime.now().obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  var isLoading = false.obs;
  RxList<InputModel> inputs = <InputModel>[].obs;
  final uuid = const Uuid();
//filter expense
  List<FilterItem> filters = [
    FilterItem(title: 'Title A-Z'),
    FilterItem(title: 'Amount < 500'),
    FilterItem(title: 'Amount > 200'),

    // Add more filters as needed
  ];
  void addInput(InputModel input) {
    isLoading.value = true;
    inputs.add(input);
    Future.delayed(const Duration(seconds: 2)); //for showing loading purpose
    Get.toNamed(RouteName.homeScreen);
    isLoading.value = false;
  }

  void updateInput(String id, InputModel updatedInput) {
    final index = inputs.indexWhere((input) => input.id == id);
    if (index != -1) {
      inputs[index] = updatedInput;
    }
  }

  void deleteInput(String id) {
    inputs.removeWhere((input) => input.id == id);
  }

  void sortByDateTime() {
    inputs.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  void sortById() {
    inputs.sort((a, b) => a.id.compareTo(b.id));
  }
}
