import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/feedback/data/datasources/feedback_remote_datasource.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';
import 'package:kelar_flutter/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class FeedbackRepositoryImpl extends FeedbackRepository {
  FeedbackRepositoryImpl(this.dataSource);

  final FeedbackRemoteDataSource dataSource;

  @override
  Either<Failure, Stream<List<FeedbackModel>>> getFeedback() {
    return safeCallSync(dataSource.getFeedbacks);
  }

  @override
  Future<Either<Failure, void>> addFeedback(FeedbackModel feedback) {
    return safeCall(() => dataSource.addFeedback(feedback));
  }

  @override
  Future<Either<Failure, void>> deleteFeedback(String id) {
    return safeCall(() => dataSource.deleteFeedback(id));
  }

  @override
  Future<Either<Failure, void>> updateFeedback(FeedbackModel feedback) {
    return safeCall(() => dataSource.updateFeedback(feedback));
  }
}
