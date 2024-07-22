part of 'feedback_bloc.dart';

@freezed
class FeedbackEvent with _$FeedbackEvent {
  const factory FeedbackEvent.started() = _Started;

  const factory FeedbackEvent.getFeedbacks() = _GetFeedbacks;

  const factory FeedbackEvent.updateFeedback(FeedbackModel feedback) =
      _UpdateFeedback;

  const factory FeedbackEvent.addFeedback(FeedbackModel feedback) =
      _AddFeedback;

  const factory FeedbackEvent.deleteFeedback(String id) = _DeleteFeedback;

  const factory FeedbackEvent.reset() = _Reset;
}
