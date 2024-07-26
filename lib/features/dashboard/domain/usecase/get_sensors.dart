import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/dashboard/data/models/sensor/sensor_model.dart';
import 'package:kelar_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class GetSensors
    implements
        UseCaseSync<Either<Failure, Stream<List<SensorModel>>>, None<void>> {
  GetSensors(this._repository);

  final DashboardRepository _repository;

  @override
  Either<Failure, Stream<List<SensorModel>>> call(None<void> params) {
    return _repository.getSensors();
  }
}
