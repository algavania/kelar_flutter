import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelar_flutter/utils/double_converter.dart';
import 'package:kelar_flutter/utils/timestamp_converter.dart';

part 'advice_model.freezed.dart';

part 'advice_model.g.dart';

@freezed
class AdviceModel with _$AdviceModel {
  const factory AdviceModel({
    required List<String> advice,
    required String quality,
  }) = _AdviceModel;

  factory AdviceModel.fromJson(Map<String, Object?> json) =>
      _$AdviceModelFromJson(json);
}

AdviceModel generateMockAdviceModel() {
  return const AdviceModel(
    advice: [
      'Lorem ipsum dolor sit amet',
      'Lorem ipsum dolor sit amet',
      'Lorem ipsum dolor sit amet',
    ],
    quality: 'Baik',
  );
}
