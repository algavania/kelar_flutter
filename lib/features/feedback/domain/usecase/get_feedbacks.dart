import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';
import 'package:kelar_flutter/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class GetFeedbacks
    implements
        UseCaseSync<Either<Failure, Stream<List<FeedbackModel>>>, None<void>> {
  GetFeedbacks(this._repository);

  final FeedbackRepository _repository;

  @override
  Either<Failure, Stream<List<FeedbackModel>>> call(None<void> params) {
    return _repository.getFeedback();
  }
}
