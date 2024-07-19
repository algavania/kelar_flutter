import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) =>
      timestamp.toDate().subtract(const Duration(hours: 7));

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
