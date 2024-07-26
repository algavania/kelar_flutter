import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/dashboard/data/models/advice/advice_model.dart';
import 'package:kelar_flutter/features/dashboard/data/models/sensor/sensor_model.dart';
import 'package:kelar_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class GetClassifications
    implements
        UseCase<Either<Failure, AdviceModel>, SensorModel> {
  GetClassifications(this._repository);

  final DashboardRepository _repository;

  @override
  Future<Either<Failure, AdviceModel>> call(SensorModel params) {
    return _repository.getClassifications(params);
  }
}
