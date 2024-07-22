import 'package:kelar_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kelar_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kelar_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:kelar_flutter/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:kelar_flutter/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:kelar_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:kelar_flutter/features/feedback/data/datasources/feedback_remote_datasource.dart';
import 'package:kelar_flutter/features/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:kelar_flutter/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:kelar_flutter/injector/injector.dart';

class RepositoryModule {
  RepositoryModule._();

  static void init() {
    Injector.instance
      ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(
          Injector.instance<AuthRemoteDataSource>(),
        ),
      )
      ..registerFactory<DashboardRepository>(
        () => DashboardRepositoryImpl(
          Injector.instance<DashboardRemoteDataSource>(),
        ),
      )
      ..registerFactory<FeedbackRepository>(
        () => FeedbackRepositoryImpl(
          Injector.instance<FeedbackRemoteDataSource>(),
        ),
      );
  }
}
