import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (key is int) return await sharedPreferences.setInt(key, value);
    if (key is bool) return await sharedPreferences.setBool(key, value);
    if (key is double) return await sharedPreferences.setDouble(key, value);
    return await sharedPreferences.setString(key, value);
  }
}
