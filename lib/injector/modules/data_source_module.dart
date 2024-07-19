import 'package:kelar_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kelar_flutter/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:kelar_flutter/injector/injector.dart';

class DataSourceModule {
  DataSourceModule._();

  static void init() {
    Injector.instance
      ..registerLazySingleton<AuthRemoteDataSource>(
        AuthRemoteDataSourceImpl.new,
      )
      ..registerLazySingleton<DashboardRemoteDataSource>(
        DashboardRemoteDataSourceImpl.new,
      );
  }
}
