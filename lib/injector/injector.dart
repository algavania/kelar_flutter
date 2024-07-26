import 'package:get_it/get_it.dart';
import 'package:kelar_flutter/injector/modules/bloc_module.dart';
import 'package:kelar_flutter/injector/modules/data_source_module.dart';
import 'package:kelar_flutter/injector/modules/repository_module.dart';
import 'package:kelar_flutter/injector/modules/use_cases_module.dart';

class Injector {
  Injector._();
  static GetIt instance = GetIt.instance;

  static void init() {
    DataSourceModule.init();
    RepositoryModule.init();
    UseCasesModule.init();
    BlocModule.init();
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
