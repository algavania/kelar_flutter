import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';
import 'package:kelar_flutter/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class UpdateFeedback
    implements
        UseCase<Either<Failure, void>, FeedbackModel> {
  UpdateFeedback(this._repository);

  final FeedbackRepository _repository;

  @override
  Future<Either<Failure, void>> call(FeedbackModel params) {
    return _repository.updateFeedback(params);
  }
}
