import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/dashboard/data/models/advice/advice_model.dart';
import 'package:kelar_flutter/features/dashboard/data/models/sensor/sensor_model.dart';

abstract class DashboardRepository {
  Either<Failure, Stream<List<SensorModel>>> getSensors();
  Future<Either<Failure, AdviceModel>> getClassifications(SensorModel data);
}
