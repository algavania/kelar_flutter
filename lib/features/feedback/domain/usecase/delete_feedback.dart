import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class DeleteFeedback
    implements
        UseCase<Either<Failure, void>, String> {
  DeleteFeedback(this._repository);

  final FeedbackRepository _repository;

  @override
  Future<Either<Failure, void>> call(String params) {
    return _repository.deleteFeedback(params);
  }
}
