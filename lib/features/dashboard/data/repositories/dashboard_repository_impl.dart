import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:kelar_flutter/features/dashboard/data/models/advice/advice_model.dart';
import 'package:kelar_flutter/features/dashboard/data/models/sensor/sensor_model.dart';
import 'package:kelar_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  DashboardRepositoryImpl(this.dataSource);

  final DashboardRemoteDataSource dataSource;

  @override
  Either<Failure, Stream<List<SensorModel>>> getSensors() {
    return safeCallSync(dataSource.getSensors);
  }

  @override
  Future<Either<Failure, AdviceModel>> getClassifications(SensorModel data) {
    return safeCall(() => dataSource.getClassification(data));
  }

  @override
  Future<Either<Failure, String>> getForecast() {
    return safeCall(dataSource.getForecast);
  }
}
