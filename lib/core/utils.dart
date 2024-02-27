import 'package:dio/dio.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Временный файл, потом сделаю поправки

class Utils {
  static String token = '';
  static String fcmToken = 'abcdefg';

  static final maskFormatter =
      MaskTextInputFormatter(mask: '+7 (###) ###-##-##');

  static bool prefix = false;
  static bool shadow = false;
  static bool phoneValid = false;
  static bool nameValid = false;
  static bool emailValid = false;
  static bool txtValid = false;
  static bool warn = false;
  static bool block = false;

  static final options = Options(
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  static Future<void> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    fcmToken = prefs.getString('fcmToken') ?? 'abcdefg';
    warn = prefs.getBool('warn') ?? false;
    block = prefs.getBool('block') ?? false;
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
