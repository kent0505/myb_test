import 'dart:developer';

import '../../core/network/dio_options.dart';

class DialogRepository {
  Future<Result> addPhone(
    String phone,
    List<int> categories,
    String comment,
  ) async {
    try {
      final response = await dio.post(
        'http://178.20.41.98/api/v1/blacklist/',
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
        return SuccessResult();
      } else {
        return ErrorResult();
      }
    } catch (e) {
      print(e);
      return ErrorResult();
    }
  }

  Future<Result> deletePhone(List<String> phones) async {
    try {
      final response = await dio.delete(
        'http://178.20.41.98/api/v1/blacklist/',
        data: {
          'phone_numbers': phones,
        },
        options: options,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 204) {
        return SuccessResult();
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

class SuccessResult extends Result {}

class ErrorResult extends Result {}
