import 'package:kelar_flutter/core/enum.dart';
import 'package:kelar_flutter/database/db_constants.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';
import 'package:kelar_flutter/utils/logger.dart';
import 'package:kelar_flutter/utils/shared_preferences_util.dart';

abstract class FeedbackRemoteDataSource {
  Stream<List<FeedbackModel>> getFeedbacks();

  Future<void> addFeedback(FeedbackModel feedback);

  Future<void> updateFeedback(FeedbackModel feedback);

  Future<void> deleteFeedback(String id);
}

class FeedbackRemoteDataSourceImpl extends FeedbackRemoteDataSource {
  @override
  Stream<List<FeedbackModel>> getFeedbacks() {
    var query = DbConstants.db
        .collection(DbConstants.feedbacks)
        .where('createdBy', isEqualTo: DbConstants.auth.currentUser?.uid)
        .orderBy('createdAt', descending: true);

    if (SharedPreferencesUtil.getUserData()?.role == RoleEnum.manager.name) {
      query = DbConstants.db
          .collection(DbConstants.feedbacks)
          .orderBy('createdAt', descending: true);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
            final data =
                FeedbackModel.fromJson(doc.data()).copyWith(id: doc.id);
            logger.d('feedback id ${data.id}');
            return data;
          }).toList(),
        );
  }

  @override
  Future<void> addFeedback(FeedbackModel feedback) {
    return DbConstants.db
        .collection(DbConstants.feedbacks)
        .add(feedback.toJson());
  }

  @override
  Future<void> deleteFeedback(String id) {
    return DbConstants.db.collection(DbConstants.feedbacks).doc(id).delete();
  }

  @override
  Future<void> updateFeedback(FeedbackModel feedback) {
    return DbConstants.db
        .collection(DbConstants.feedbacks)
        .doc(feedback.id)
        .update(feedback.toJson());
  }
}
