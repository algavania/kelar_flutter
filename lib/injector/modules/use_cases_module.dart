import 'package:kelar_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/login.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/logout.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/register.dart';
import 'package:kelar_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:kelar_flutter/features/dashboard/domain/usecase/get_sensors.dart';
import 'package:kelar_flutter/injector/injector.dart';

class UseCasesModule {
  UseCasesModule._();

  static void init() {
    /// Auth Use Cases
    Injector.instance
      ..registerLazySingleton<Login>(
        () => Login(
          Injector.instance<AuthRepository>(),
        ),
      )
      ..registerLazySingleton<Register>(
        () => Register(
          Injector.instance<AuthRepository>(),
        ),
      )
      ..registerLazySingleton<Logout>(
        () => Logout(
          Injector.instance<AuthRepository>(),
        ),
    /// Dashboard Use Cases
      )..registerLazySingleton<GetSensors>(
          () => GetSensors(
        Injector.instance<DashboardRepository>(),
      ),
    );
  }
}
