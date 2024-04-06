import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:personal_expense_tracker/modules/auth%20module/models/token_model.dart';

//This is singleton pattern for create only one instance of this class in entire app
class AuthServices {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // AuthServices._(); //private const
  static final AuthServices instance = AuthServices();

  // factory AuthServices() {
  //   return _instance;
  // }
  // static  get instance=> _instance;

  Future<void> storeToken(Tokens tokens) async {
    // Convert token map to JSON string since secure storage only accept string type as value. no needed this if it accept dynamic
    String tokenJson = json.encode(tokens.toJson());
    await secureStorage.write(key: "tokens", value: tokenJson);
  }

  Future<Tokens> getTokenFromStoarge() async {
    String jsonString = await secureStorage.read(key: "tokens") ?? "";
    if (jsonString.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(jsonString);

      return Tokens.fromJson(json);
    } else {
      return Tokens.empty();
    }
  }

  deleteTokens() async {
    await secureStorage.delete(key: "tokens");
  }
}
