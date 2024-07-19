import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/dashboard/data/sensor/sensor_model.dart';

abstract class DashboardRepository {
  Either<Failure, Stream<List<SensorModel>>> getSensors();
}
