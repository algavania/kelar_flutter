import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_model.freezed.dart';

part 'feedback_model.g.dart';

@freezed
class FeedbackModel with _$FeedbackModel {
  const factory FeedbackModel({
    required DateTime createdAt,
    required DateTime updatedAt,
    required String content,
    required String createdBy,
    required int urgencyLevel,
    String? actionDescription,
    String? actionBy,
    String? id,
  }) = _FeedbackModel;

  factory FeedbackModel.fromJson(Map<String, Object?> json) =>
      _$FeedbackModelFromJson(json);
}

FeedbackModel generateMockFeedbackModel() {
  return FeedbackModel(
    content: 'Description',
    createdBy: '',
    urgencyLevel: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
