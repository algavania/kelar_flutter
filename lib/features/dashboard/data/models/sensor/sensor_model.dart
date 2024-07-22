import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelar_flutter/utils/double_converter.dart';
import 'package:kelar_flutter/utils/timestamp_converter.dart';

part 'sensor_model.freezed.dart';

part 'sensor_model.g.dart';

@freezed
class SensorModel with _$SensorModel {
  const factory SensorModel({
    @DoubleConverter()
    required double co,
    @DoubleConverter()
    required double co2,
    @DoubleConverter()
    required double humidity,
    @DoubleConverter()
    required double pm25,
    @DoubleConverter()
    required double temperature,
    @TimestampConverter() required DateTime date,
    @JsonKey(includeToJson: false, includeFromJson: false) String? id,
  }) = _SensorModel;

  factory SensorModel.fromJson(Map<String, Object?> json) =>
      _$SensorModelFromJson(json);
}

SensorModel generateMockSensorModel() {
  return SensorModel(
    co: 0.28,
    co2: 322,
    humidity: 80,
    pm25: 0.28,
    temperature: 32.8,
    date: DateTime.now(),
  );
}
