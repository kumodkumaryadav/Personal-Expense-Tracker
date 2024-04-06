import 'package:get_storage/get_storage.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/model/input_model.dart';

class StorageServices {
  GetStorage storage = GetStorage();

  storeExpense(List<InputModel> inputModelList) async {
    await storage.write("inputModelList", inputModelList);
  }

  List<InputModel> getExpenseFromStorage() {
    return storage.read("inputModelList");
  }
}
