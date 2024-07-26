part of 'feedback_bloc.dart';

@freezed
class FeedbackState with _$FeedbackState {
  const factory FeedbackState.initial() = _Initial;
  const factory FeedbackState.loading() = _Loading;
  const factory FeedbackState.added() = _Added;
  const factory FeedbackState.loaded() = _Loaded;
  const factory FeedbackState.edited() = _Edited;
  const factory FeedbackState.deleted() = _Deleted;
  const factory FeedbackState.error(String message) = _Error;
}
