import 'package:kelar_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/login.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/logout.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/register.dart';
import 'package:kelar_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:kelar_flutter/features/dashboard/domain/usecase/get_classifications.dart';
import 'package:kelar_flutter/features/dashboard/domain/usecase/get_forecast.dart';
import 'package:kelar_flutter/features/dashboard/domain/usecase/get_sensors.dart';
import 'package:kelar_flutter/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:kelar_flutter/features/feedback/domain/usecase/add_feedback.dart';
import 'package:kelar_flutter/features/feedback/domain/usecase/delete_feedback.dart';
import 'package:kelar_flutter/features/feedback/domain/usecase/get_feedbacks.dart';
import 'package:kelar_flutter/features/feedback/domain/usecase/update_feedback.dart';
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
      )
      ..registerLazySingleton<GetSensors>(
        () => GetSensors(
          Injector.instance<DashboardRepository>(),
        ),
      )
      ..registerLazySingleton<GetClassifications>(
            () => GetClassifications(
          Injector.instance<DashboardRepository>(),
        ),
      )
      ..registerLazySingleton<GetForecast>(
            () => GetForecast(
          Injector.instance<DashboardRepository>(),
        ),
      )
    /// Feedback Use Cases
      ..registerLazySingleton<GetFeedbacks>(
        () => GetFeedbacks(
          Injector.instance<FeedbackRepository>(),
        ),
      )
      ..registerLazySingleton<AddFeedback>(
        () => AddFeedback(
          Injector.instance<FeedbackRepository>(),
        ),
      )
      ..registerLazySingleton<UpdateFeedback>(
        () => UpdateFeedback(
          Injector.instance<FeedbackRepository>(),
        ),
      )
      ..registerLazySingleton<DeleteFeedback>(
        () => DeleteFeedback(
          Injector.instance<FeedbackRepository>(),
        ),
      );
  }
}
