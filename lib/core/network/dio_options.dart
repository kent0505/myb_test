import 'package:dio/dio.dart';

import '../utils.dart';

final dio = Dio();

final options = Options(
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${Utils.token}',
  },
  receiveTimeout: const Duration(seconds: 5),
  sendTimeout: const Duration(seconds: 5),
);

final options2 = Options(
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${Utils.token}',
  },
  receiveTimeout: const Duration(seconds: 5),
  sendTimeout: const Duration(seconds: 5),
  validateStatus: (status) => true,
);
