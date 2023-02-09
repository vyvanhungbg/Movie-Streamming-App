import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';

class DioClient {
  static Dio? dio;

  static Dio provideDioClient() {
    if (dio == null) {
      dio = Dio();
      dio?.interceptors.add(
        DioLoggingInterceptor(
          level: Level.body,
          compact: false,
        ),
      );
    }
    return dio!;
  }
}
