import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';

abstract class FeedbackRepository {
  Either<Failure, Stream<List<FeedbackModel>>> getFeedback();
  Future<Either<Failure, void>> addFeedback(FeedbackModel feedback);
  Future<Either<Failure, void>> updateFeedback(FeedbackModel feedback);
  Future<Either<Failure, void>> deleteFeedback(String id);
}
