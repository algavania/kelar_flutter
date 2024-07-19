import 'dart:convert';

import 'package:kelar_flutter/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs ?? await SharedPreferences.getInstance();
  }

  static UserModel? getUserData() {
    final res = prefs?.getString('user');
    if (res == null) return null;
    return UserModel.fromJson(jsonDecode(res) as Map<String, dynamic>);
  }

  static Future<void> setUserData(UserModel user) async {
    await prefs?.setString('user', jsonEncode(user.toJson()));
  }

  static Future<void> clearAllPrefs() async {
    await prefs?.clear();
  }
}
