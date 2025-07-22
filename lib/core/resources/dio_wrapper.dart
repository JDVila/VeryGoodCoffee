// ignore_for_file: public_member_api_docs, sort_constructors_first, one_member_abstracts
import 'package:dio/dio.dart';

abstract class DioWrapper {
  Future<Map<String, dynamic>> get(String url);
}

class DioReal extends DioWrapper {
  DioReal(
    this.dio,
  );
  final Dio dio;

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(url);
      return {'data': response.data, 'statusCode': response.statusCode};
    } on DioException catch (e) {
      return {'data': e.error.toString(), 'statusCode': e.response?.statusCode};
    }
  }
}

class DioFake extends DioWrapper {
  DioFake(
    this.dio,
  );
  final Dio dio;

  @override
  Future<Map<String, dynamic>> get(String url) async {
    final fakeResponse = {
      'file': 'https://coffee.alexflipnote.dev/lEnU7VrzuoU_coffee.jpg'
    };
    return {'data': fakeResponse, 'statusCode': 200};
  }
}
