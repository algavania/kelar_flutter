import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kelar_flutter/database/db_constants.dart';
import 'package:kelar_flutter/features/dashboard/data/models/advice/advice_model.dart';
import 'package:kelar_flutter/features/dashboard/data/models/response/response_model.dart';
import 'package:kelar_flutter/features/dashboard/data/models/sensor/sensor_model.dart';
import 'package:kelar_flutter/utils/extensions.dart';

abstract class DashboardRemoteDataSource {
  Stream<List<SensorModel>> getSensors();

  Future<AdviceModel> getClassification(SensorModel data);
}

class DashboardRemoteDataSourceImpl extends DashboardRemoteDataSource {
  @override
  Stream<List<SensorModel>> getSensors() {
    return DbConstants.db
        .collection(DbConstants.sensors)
        .orderBy('date', descending: true)
        .limit(100)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final sensor = SensorModel.fromJson(doc.data());
            return sensor;
          }).toList(),
        );
  }

  @override
  Future<AdviceModel> getClassification(SensorModel data) async {
    final body = {
      'co': data.co,
      'co2': data.co2,
      'humidity': data.humidity,
      'pm25': data.pm25,
      'temperature': data.temperature,
      'date': data.date.toFormattedDateWithHour(),
    };

    final res = await http.post(
      Uri.parse('https://kelar-be.vercel.app/api/predict'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    final result =
        ResponseModel.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    final advice = AdviceModel.fromJson(result.data as Map<String, dynamic>);
    return advice;
  }
}
