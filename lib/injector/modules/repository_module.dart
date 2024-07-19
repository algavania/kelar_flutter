import 'package:kelar_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kelar_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kelar_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:kelar_flutter/injector/injector.dart';

class RepositoryModule {
  RepositoryModule._();

  static void init() {
    Injector.instance
      .registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(
          Injector.instance<AuthRemoteDataSource>(),
        ),
      );
  }
}
