import 'package:kelar_flutter/features/auth/view/bloc/auth_bloc.dart';
import 'package:kelar_flutter/features/dashboard/view/bloc/dashboard_bloc.dart';
import 'package:kelar_flutter/features/feedback/view/bloc/feedback_bloc.dart';
import 'package:kelar_flutter/injector/injector.dart';

class BlocModule {
  BlocModule._();

  static void init() {
    Injector.instance
      ..registerLazySingleton<AuthBloc>(
        AuthBloc.new,
      )
      ..registerLazySingleton<DashboardBloc>(
        DashboardBloc.new,
      )
      ..registerLazySingleton<FeedbackBloc>(
        FeedbackBloc.new,
      );
  }
}
