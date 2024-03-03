import 'dart:developer';

import '../../core/network/dio_options.dart';
import 'models/category.dart';

class MenuRepository {
  Future<Result> fetchCategories() async {
    try {
      final response = await dio.get(
        'http://178.20.41.98/api/v1/categories/',
        options: options,
      );

      log(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == 200) {
        final List result = response.data;
        final categories = result.map((item) {
          return Category.fromJson(item);
        }).toList();

        return CategoriesResult(categories);
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

class CategoriesResult extends Result {
  final List<Category> categories;
  CategoriesResult(this.categories);
}

class ErrorResult extends Result {}
