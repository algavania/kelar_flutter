import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_model.freezed.dart';

part 'feedback_model.g.dart';

@freezed
class FeedbackModel with _$FeedbackModel {
  const factory FeedbackModel({
    required DateTime createdAt,
    required DateTime updatedAt,
    required String title,
    required String content,
    required int urgencyLevel,
    String? action,
    String? actionDescription,
    String? actionBy,
    String? id,
  }) = _FeedbackModel;

  factory FeedbackModel.fromJson(Map<String, Object?> json) =>
      _$FeedbackModelFromJson(json);
}

FeedbackModel generateMockFeedbackModel() {
  return FeedbackModel(
    title: 'Title',
    content: 'Description',
    urgencyLevel: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
