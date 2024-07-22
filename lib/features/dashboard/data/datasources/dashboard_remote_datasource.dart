import 'package:kelar_flutter/database/db_constants.dart';
import 'package:kelar_flutter/features/dashboard/data/sensor/sensor_model.dart';

abstract class DashboardRemoteDataSource {
  Stream<List<SensorModel>> getSensors();
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
}
