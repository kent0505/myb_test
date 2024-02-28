import 'dart:developer';

import '../../core/constants.dart';
import '../../core/network/dio_options.dart';

class CheckRepository {
  Future<CheckResult> getPhoneInfo(String phone) async {
    try {
      final response = await dio.get(
        '${Const.phoneInfoUrl}?phone_number=$phone',
        options: options,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
        return CheckSuccessResult(
          response.data['callfilter_info']['blocked'] ?? 0,
          response.data['operator_info']['old_operator'] ??
              response.data['operator_info']['operator'],
          response.data['operator_info']['region'] ?? '',
        );
        // if (response.data['operator_info']['info']
        //     .toString()
        //     .contains('Номер не найден')) {

        //   return CheckNotFoundResult();
        // } else {
        //   return CheckSuccessResult(
        //     response.data['callfilter_info']['blocked'],
        //     response.data['operator_info']['old_operator'],
        //     response.data['operator_info']['region'],
        //   );
        // }
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
