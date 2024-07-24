import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/dashboard/data/models/advice/advice_model.dart';
import 'package:kelar_flutter/features/dashboard/data/models/sensor/sensor_model.dart';
import 'package:kelar_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class GetForecast
    implements
        UseCase<Either<Failure, String>, None<void>> {
  GetForecast(this._repository);

  final DashboardRepository _repository;

  @override
  Future<Either<Failure, String>> call(None<void> params) {
    return _repository.getForecast();
  }
}
