// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:personal_expense_tracker/modules/expense%20tracker/model/input_model.dart';

// class StorageServices {
//   final GetStorage _storage = GetStorage();

//   storeExpenseToStorage(List<InputModel> inputModelList) async {
//     List<dynamic> mapList = [];
//     inputModelList.forEach((element) {
//       mapList.add(element.toJson());
//     });

//     await _storage.write("inputModelList", mapList);
//   }

//   List<InputModel> getExpenseFromStorage() {
//     List<dynamic> dataList = _storage.read("inputModelList") ?? [];
//     List<InputModel> dataModel = [];
//     dataList.forEach((element) {
//       dataModel.add(InputModel.fromJson(element));
//     });

//     return dataModel;
//   }

//   deleteDataFromStorage() async {
//     await _storage.remove("inputModelList");
//   }
// }

//Below code follow singleton
// class StorageServices {
//   StorageServices._();
//   final GetStorage _storage = GetStorage();
//   static final _instance = StorageServices._();
//   factory StorageServices() {
//     return _instance;
//   }

//   storeExpenseToStorage(List<InputModel> inputModelList) async {
//     List<dynamic> mapList = [];
//     inputModelList.forEach((element) {
//       mapList.add(element.toJson());
//     });

//     await _storage.write("inputModelList", mapList);
//   }

//   List<InputModel> getExpenseFromStorage() {
//     List<dynamic> dataList = _storage.read("inputModelList") ?? [];
//     List<InputModel> dataModel = [];
//     dataList.forEach((element) {
//       dataModel.add(InputModel.fromJson(element));
//     });

//     return dataModel;
//   }

//   deleteDataFromStorage() async {
//     await _storage.remove("inputModelList");
//   }
// }

//below code follow SOLID principle

//SRP(Sngle responsibily Principle which means each class should one reason to change like storage not Serialization)
abstract class StorageRepository {
  storeData(String key, List<Map<String, dynamic>> data);
  retrieveData(String key);
  deleteData(String key);
}

class GetStorageRepository implements StorageRepository {
  final GetStorage _storage = GetStorage();
  @override
  deleteData(String key) async {
    await _storage.remove(key);
  }

  @override
  Future<List<Map<String, dynamic>>> retrieveData(String key) async {
    return await _storage.read(key) ?? [];
  }

  @override
  storeData(String key, List<Map<String, dynamic>> data) async {
    await _storage.write(key, data);
  }
}

//for data serialization before storing and after retriving
class DataSerializer {
  toJsonList(List<InputModel> inputModel) {
    return inputModel.map((e) => e.toJson()).toList();
  }

  List<InputModel> fromJsonList(List<Map<String, dynamic>> dataList) {
    return dataList.map((json) => InputModel.fromJson(json)).toList();
  }
}

class StorageServices {
  final StorageRepository _storageRepository;
  final DataSerializer _dataSerializer;
  //  StorageServices({this._storageRepository, this._dataSerializer}); //its named parameter that doesnot care about order since its specify using name

  StorageServices(this._storageRepository,
      this._dataSerializer); //have to provide parameter in same order as it is positional parameter
  storeExpenseToStorage(List<InputModel> inputModelDataList) {
    final dataList = _dataSerializer.toJsonList(inputModelDataList);
    _storageRepository.storeData("inputDataList", dataList);
  }

  Future<List<InputModel>> retrieveInputDataFromStorage() async{
    final List<Map<String, dynamic>> dataList =
      await  _storageRepository.retrieveData("inputDataList") ?? [];
    return _dataSerializer.fromJsonList(dataList);
  }

  deleteDataFromStorage() {
    _storageRepository.deleteData("inputDataList");
  }
}
