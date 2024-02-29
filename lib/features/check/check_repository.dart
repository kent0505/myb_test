import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/constants.dart';
import '../../core/network/dio_options.dart';
import '../../core/utils.dart';

class CheckRepository {
  Future<Result> getPhoneInfo(String phone) async {
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

  Future<Result> addToBlacklist(
    String phone,
    List<int> categories,
    String comment,
  ) async {
    try {
      final response = await dio.post(
        Const.addToBlackListURL,
        data: {
          'phone_number': phone,
          'categories': categories,
          'comment': comment,
        },
        options: options,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 201) {
        return AddedResult();
      } else {
        return CheckErrorResult();
      }
    } catch (e) {
      print(e);
      return CheckErrorResult();
    }
  }
}

abstract class Result {}

class CheckSuccessResult extends Result {
  final int blocked;
  final String operator;
  final String region;
  CheckSuccessResult(
    this.blocked,
    this.operator,
    this.region,
  );
}

class AddedResult extends Result {}

class CheckNotFoundResult extends Result {}

class CheckErrorResult extends Result {}
