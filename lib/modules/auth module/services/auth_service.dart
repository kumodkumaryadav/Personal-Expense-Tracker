import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:personal_expense_tracker/modules/auth%20module/models/token_model.dart';

//This dependency injection way its improved in Clean Code branch
class AuthServices {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
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
