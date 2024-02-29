import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/constants.dart';
import '../../core/network/dio_options.dart';
import '../../core/utils.dart';

class CheckRepository {
  Future<CheckResult> getPhoneInfo(String phone) async {
    try {
      final response = await dio.get(
        '${Const.phoneInfoURL}?phone_number=$phone',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Utils.token}',
          },
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
          validateStatus: (status) => true,
        ),
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
        return CheckSuccessResult(
          response.data['callfilter_info']['blocked'] ?? 0,
          response.data['operator_info']['operator'] ?? '',
          response.data['operator_info']['region'] ?? '',
        );
      } else if (response.statusCode == 404) {
        if (response.data['callfilter_info'] != null) {
          return CheckSuccessResult(
            response.data['callfilter_info']['blocked'] ?? 0,
            '',
            '',
          );
        } else {
          return CheckErrorResult();
        }
      } else {
        return CheckErrorResult();
      }
    } catch (e) {
      print(e);
      return CheckErrorResult();
    }
  }

  Future addToBlacklist() async {
    try {
      final response = await dio.post(
        '${Const.phoneInfoURL}?phone_number',
        options: options,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
      } else {
        return CheckErrorResult();
      }
    } catch (e) {
      print(e);
      return CheckErrorResult();
    }
  }
}

abstract class CheckResult {}

class CheckSuccessResult extends CheckResult {
  final int blocked;
  final String operator;
  final String region;
  CheckSuccessResult(
    this.blocked,
    this.operator,
    this.region,
  );
}

class CheckNotFoundResult extends CheckResult {}

class CheckErrorResult extends CheckResult {}
