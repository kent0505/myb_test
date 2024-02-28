import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/constants.dart';
import '../../core/network/dio_options.dart';

class AuthRepository {
  Future<Result> registerGetCode(String phone) async {
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

  Future<Result> login(String phone, String fcm) async {
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

  Future<Result> register(String phone, String fcm, String reason) async {
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
}

abstract class Result {}

class RegisteredResult extends Result {
  final bool registered;
  RegisteredResult(this.registered);
}

class SuccessResult extends Result {
  final String token;
  SuccessResult(this.token);
}

class ErrorResult extends Result {}

class CodeResult extends Result {
  final int code;
  final bool registered;
  CodeResult(
    this.code,
    this.registered,
  );
}

class ExceptionResult extends Result {
  final String error;
  ExceptionResult(this.error);
}
