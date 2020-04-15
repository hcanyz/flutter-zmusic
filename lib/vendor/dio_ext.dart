import 'package:dio/dio.dart';

class Https {
  Https._inner();

  static Dio _dio;

  static Map<String, String> optHeader = {'accept-language': 'zh-cn'};

  static Dio get dio =>
      _dio ??= Dio(BaseOptions(connectTimeout: 5000, headers: optHeader));
}
