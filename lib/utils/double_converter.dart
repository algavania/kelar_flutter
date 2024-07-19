import 'package:freezed_annotation/freezed_annotation.dart';

class DoubleConverter implements JsonConverter<double, String> {
  const DoubleConverter();

  @override
  double fromJson(String data) =>
      double.parse(data);

  @override
  String toJson(double date) => date.toString();
}
