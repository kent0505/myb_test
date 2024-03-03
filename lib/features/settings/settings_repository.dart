import 'dart:developer';

import '../../core/network/dio_options.dart';

class SettingsRepository {
  Future<bool> appeal(String name, String email, String message) async {
    try {
      final response = await dio.post(
        'http://178.20.41.98/api/v1/users/contact-us/',
        data: {
          'name': name,
          'email': email,
          'message': message,
        },
        options: options,
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
