import 'dart:developer';

import '../../core/constants.dart';
import '../../core/network/dio_options.dart';
import 'models/phone.dart';

class MydbRepository {
  Future<Result> fetchPhones() async {
    try {
      final response = await dio.get(
        Const.blackListURL,
        options: options,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
        final List result = response.data;
        final blacklist = result.map((item) {
          return Phone.fromJson(item);
        }).toList();

        return BlacklistResult(blacklist);
      } else {
        return ErrorResult();
      }
    } catch (e) {
      print(e);
      return ErrorResult();
    }
  }

  Future<Result> deletePhones(List<String> phones) async {
    try {
      final response = await dio.delete(
        '${Const.baseURL}/blacklist/',
        data: {'phone_numbers': phones},
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
      return ErrorResult();
    }
  }
}

abstract class Result {}

class BlacklistResult extends Result {
  final List<Phone> blacklist;
  BlacklistResult(this.blacklist);
}

class SuccessResult extends Result {}

class ErrorResult extends Result {}
