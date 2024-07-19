import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelar_flutter/features/dashboard/data/sensor/sensor_model.dart';
import 'package:kelar_flutter/features/dashboard/domain/usecase/get_sensors.dart';
import 'package:kelar_flutter/injector/injector.dart';
import 'package:kelar_flutter/utils/logger.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState.initial()) {
    on<_GetSensors>(
      _onGetSensors,
    );
  }

  final _getSensors = Injector.instance<GetSensors>();
  Stream<List<SensorModel>>? sensorStream;

  Future<void> _onGetSensors(
    _GetSensors event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardState.loading());
    _getSensors.call(const None())
      .fold((failure) {
        emit(DashboardState.error(failure.message));
      }, (data) {
        logger.d('data $data');
        sensorStream = data;
        emit(const DashboardState.loaded());
      });
  }
}
