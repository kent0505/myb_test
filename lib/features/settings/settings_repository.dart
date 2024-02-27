import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/constants.dart';
import '../../core/utils.dart';

class SettingsRepository {
  final dio = Dio();

  Future<bool> appeal(String name, String email, String message) async {
    try {
      final response = await dio.post(
        Const.appealUrl,
        data: {
          'name': name,
          'email': email,
          'message': message,
        },
        options: Utils.options,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
