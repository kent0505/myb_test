import 'dart:developer';

import '../../core/network/dio_options.dart';

class HelpRepository {
  Future<bool> help(String name, String phone, String email) async {
    try {
      final response = await dio.post(
        'http://178.20.41.98/api/v1/legal_help/consultation_requests/',
        data: {
          'name': name,
          'phone_number': phone,
          'email': email,
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
