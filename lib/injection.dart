import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/sqfite/sqlfile_helper.dart';
import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'injection.config.dart' as config;

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await initAll();
}

Future<void> initAll() async {
  // getIt.registerSingletonAsync<Database>(() => SqlFileHelper.initDatabase());

  getIt.registerSingleton<Dio>(Dio()
    ..interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    ));

  getIt.registerSingleton<String>(ApiEndPoints.baseUrl,
      instanceName: ApiEndPoints.nameOfBaseUrl);
  await getIt.init();
}
