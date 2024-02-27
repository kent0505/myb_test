import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/constants.dart';
import 'auth_result.dart';

class AuthRepository {
  final dio = Dio();

  Future<AuthResult> registerGetCode(String phone) async {
    try {
      final response = await dio.post(
        Const.registerGetCodeURL,
        data: {
          'phone_number': phone,
        },
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
        return CodeResult(
          response.data['code'],
          response.data['is_registered'],
        );
      } else {
        return ErrorResult();
      }
    } catch (e) {
      print(e);
      return ExceptionResult(e.toString());
    }
  }

  Future<AuthResult> login(String phone, String fcm) async {
    try {
      final response = await dio.post(
        Const.loginURL,
        data: {
          'phone_number': phone,
          'fcm_token': fcm,
        },
        options: Options(
          validateStatus: (status) => true,
        ),
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
        return SuccessResult(response.data['token']['access']);
      } else {
        return ErrorResult();
      }
    } catch (e) {
      print(e);
      return ExceptionResult(e.toString());
    }
  }

  Future<AuthResult> register(String phone, String fcm, String reason) async {
    try {
      final response = await dio.post(
        Const.registerURL,
        data: {
          'phone_number': phone,
          'fcm_token': fcm,
          "usage_purpose": reason,
        },
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 201) {
        return SuccessResult(response.data['token']['access']);
      } else {
        return ErrorResult();
      }
    } catch (e) {
      print(e);
      return ExceptionResult(e.toString());
    }
  }

  // Future<AuthResult> checkRegister(String phone) async {
  //   try {
  //     final response = await dio.post(
  //       Const.registerCheckURL,
  //       data: {
  //         'login': '+7$phone',
  //       },
  //       options: Options(
  //         validateStatus: (status) => true,
  //       ),
  //     );

  //     log(response.statusCode.toString());
  //     print(response.data);

  //     if (response.statusCode == 200) {
  //       return RegisteredResult(response.data['is_registered']);
  //     } else {
  //       return ErrorResult();
  //     }
  //   } catch (e) {
  //     print(e);
  //     return ExceptionResult(e.toString());
  //   }
  // }
}
