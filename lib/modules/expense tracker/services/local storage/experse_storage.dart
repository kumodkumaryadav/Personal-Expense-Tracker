import 'package:get_storage/get_storage.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/model/input_model.dart';

class StorageServices {
  GetStorage storage = GetStorage();

  storeExpenseToStorage(List<InputModel> inputModelList) async {
    List<dynamic> mapList = [];
    inputModelList.forEach((element) {
      mapList.add(element.toJson());
    });

    await storage.write("inputModelList", mapList);
  }

  List<InputModel> getExpenseFromStorage() {
    List<dynamic> dataList = storage.read("inputModelList")??[];
    List<InputModel> dataModel = [];
    dataList.forEach((element) {
      dataModel.add(InputModel.fromJson(element));
    });
  
    return dataModel;
  }

  deleteDataFromStorage() async {
    await storage.remove("inputModelList");
  }
}
