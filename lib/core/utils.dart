import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../features/menu/models/category.dart';
import '../features/mydb/models/phone.dart';

// Временный файл, потом сделаю поправки

class Utils {
  static String token = '';
  static String fcmToken = 'abcdefg';
  static bool blockSettings = false;

  static bool phoneValid = false;
  static bool nameValid = false;
  static bool emailValid = false;
  static bool txtValid = false;
  static bool warn = false;
  static bool block = false;

  static List<Category> categories = [];
  static List<Phone> blacklist = [];
  static List<int> cid = [];

  static String formatPhone(String phone) {
    return phone.replaceAll(' (', '').replaceAll(') ', '').replaceAll('-', '');
  }

  // static void clearData() {
  //   for (var category in Utils.categories) {
  //     if (category.checked) {
  //       category.checked = false;
  //     }
  //   }
  //   for (var phone in Utils.blacklist) {
  //     if (phone.checked) {
  //       phone.checked = false;
  //     }
  //   }
  // }

  static void getCid() {
    cid = [];
    for (var category in Utils.categories) {
      if (category.checked) {
        cid.add(category.id);
      }
    }
  }

  static bool checkActiveCheckboxes() {
    for (var category in Utils.categories) {
      if (category.checked) {
        return true;
      }
    }
    return false;
  }

  static bool checkActiveCheckboxes2() {
    for (var category in Utils.categories) {
      if (category.checked && phoneValid) {
        return true;
      }
    }
    return false;
  }

  static bool phoneChecked() {
    for (var phone in blacklist) {
      if (phone.checked) {
        return true;
      }
    }
    return false;
  }

  static Future<void> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    fcmToken = prefs.getString('fcmToken') ?? 'abcdefg';
    warn = prefs.getBool('warn') ?? false;
    block = prefs.getBool('block') ?? false;
    blockSettings = prefs.getBool('blockSettings') ?? false;
    // print('fcmtoken: $fcmToken');
  }

  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();
    final fcmToken = await messaging.getToken();
    if (fcmToken != null) {
      saveData('fcmToken', fcmToken);
    }
  }
}
