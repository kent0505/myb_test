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
        final phones = result.map((item) {
          return Phone.fromJson(item);
        }).toList();

        return PhonesResult(phones);
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

class PhonesResult extends Result {
  final List<Phone> blacklist;
  PhonesResult(this.blacklist);
}

class ErrorResult extends Result {}
