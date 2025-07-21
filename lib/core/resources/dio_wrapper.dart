// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

abstract class DioWrapper {
  Future<List<dynamic>> get(String url);
}

class DioReal extends DioWrapper {
  DioReal(
    this.dio,
  );
  final Dio dio;

  @override
  Future<List<dynamic>> get(String url) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(url);
      return [response.data, response.statusCode];
    } on DioException catch (e) {
      return [e.message, e.response?.statusCode];
    }
  }
}

class DioFake extends DioWrapper {
  DioFake(
    this.dio,
  );
  final Dio dio;

  @override
  Future<List<dynamic>> get(String url) async {
    final Map<String, dynamic> map = {'file': 'Map<String, dynamic>{}'};
    return [map, 200];
  }
}
