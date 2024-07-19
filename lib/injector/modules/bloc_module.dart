import 'package:kelar_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/login.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/logout.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/register.dart';
import 'package:kelar_flutter/features/auth/view/bloc/auth_bloc.dart';
import 'package:kelar_flutter/injector/injector.dart';

class BlocModule {
  BlocModule._();

  static void init() {
    Injector.instance.registerLazySingleton<AuthBloc>(
      AuthBloc.new,
    );
  }
}
