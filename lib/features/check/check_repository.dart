import 'dart:developer';

import '../../core/constants.dart';
import '../../core/network/dio_options.dart';
import 'models/phone_info.dart';

class CheckRepository {
  Future<Result> getPhoneOperator(String phone) async {
    try {
      final response = await dio.get(
        '${Const.phoneInfoURL}?phone_number=$phone',
        options: options2,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
        final data = PhoneInfo.fromJson(response.data);
        return SuccessResult(
          data.operator ?? '',
          data.region ?? '',
        );
      } else {
        return SuccessResult('', '');
      }
    } catch (e) {
      print(e);
      return SuccessResult('', '');
    }
  }

  Future<Result> getPhoneCategories(String phone) async {
    try {
      final response = await dio.get(
        'http://178.20.41.98/api/v1/blacklist/public-info/$phone/',
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
}

abstract class Result {}

class SuccessResult extends Result {
  final String operator;
  final String region;
  SuccessResult(
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
