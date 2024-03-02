import 'dart:developer';

import '../../core/constants.dart';
import '../../core/network/dio_options.dart';
import 'models/phone_info.dart';

class CheckRepository {
  Future<Result> getPhoneInfo(String phone) async {
    try {
      final response = await dio.get(
        '${Const.phoneInfoURL}?phone_number=$phone',
        options: options2,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
        final data = PhoneOperator.fromJson(response.data);
        return SuccessResult(
          data.blocked,
          data.operator ?? '',
          data.region ?? '',
        );
      } else if (response.statusCode == 404) {
        if (response.data['callfilter_info'] != null) {
          return SuccessResult(
            response.data['callfilter_info']['blocked'] ?? 0,
            '',
            '',
          );
        } else {
          return ErrorResult();
        }
      } else {
        return ErrorResult();
      }
    } catch (e) {
      print(e);
      return ErrorResult();
    }
  }

  Future<Result> getPhoneFromBlacklist(String phone) async {
    try {
      final response = await dio.get(
        'http://178.20.41.98/api/v1/blacklist/',
        data: {'phone_number': phone},
        options: options2,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
        return GetResult(List<int>.from(response.data['categories']));
      } else {
        return GetResult([]);
      }
    } catch (e) {
      return GetResult([]);
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
        return ErrorResult();
      }
    } catch (e) {
      print(e);
      return ErrorResult();
    }
  }
}

abstract class Result {}

class SuccessResult extends Result {
  final int blocked;
  final String operator;
  final String region;
  SuccessResult(
    this.blocked,
    this.operator,
    this.region,
  );
}

class GetResult extends Result {
  final List<int> categories;
  GetResult(this.categories);
}

class AddedResult extends Result {}

class NotFoundResult extends Result {}

class ErrorResult extends Result {}
