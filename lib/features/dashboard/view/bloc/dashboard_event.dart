part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.started() = _Started;

  const factory DashboardEvent.getSensors() = _GetSensors;

  const factory DashboardEvent.getAnalytic() = _GetAnalytic;

  const factory DashboardEvent.getClassifications(SensorModel data) =
      _GetClassifications;

  const factory DashboardEvent.reset() = _Reset;
}
