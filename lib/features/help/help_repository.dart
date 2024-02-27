import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/constants.dart';
import '../../core/utils.dart';

class HelpRepository {
  final dio = Dio();

  Future<bool> help(String name, String phone, String email) async {
    try {
      final response = await dio.post(
        Const.helpUrl,
        data: {
          'name': name,
          'phone_number': phone,
          'email': email,
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
