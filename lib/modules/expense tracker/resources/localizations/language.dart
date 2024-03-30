import 'package:get/route_manager.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "en_us": {
          "app_title": "PERSONAL EXPENSE TRACKER",
          "no_expense_hint": "No expense!, add it from plus button"
        },
        "hindi_in": {
          "app_title": "व्यक्तिगत व्यय ट्रैकर",
          "no_expense_hint": "कोई खर्च नहीं!, इसे प्लस बटन से जोड़ें"
        }
      };
}
