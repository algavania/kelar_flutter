import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelar_flutter/features/dashboard/data/models/advice/advice_model.dart';
import 'package:kelar_flutter/features/dashboard/data/models/sensor/sensor_model.dart';
import 'package:kelar_flutter/features/dashboard/domain/usecase/get_classifications.dart';
import 'package:kelar_flutter/features/dashboard/domain/usecase/get_forecast.dart';
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
    on<_GetClassifications>(
      _onGetClassifications,
    );
    on<_GetForecast>(
      _onGetForecast,
    );
    on<_Reset>(
      _onReset,
    );
  }

  final _getSensors = Injector.instance<GetSensors>();
  final _getForecast = Injector.instance<GetForecast>();
  final _getClassifications = Injector.instance<GetClassifications>();

  List<SensorModel> lastData = [];
  Stream<List<SensorModel>>? sensorStream;
  AdviceModel? advice;
  DateTime? lastAdviceDate;
  String? forecast;

  Future<void> _onReset(
    _Reset event,
    Emitter<DashboardState> emit,
  ) async {
    sensorStream = null;
    emit(const DashboardState.initial());
  }

  Future<void> _onGetSensors(
    _GetSensors event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardState.loading());
    _getSensors.call(const None()).fold((failure) {
      emit(DashboardState.error(failure.message));
    }, (data) {
      logger.d('data $data');
      sensorStream = data;
      emit(const DashboardState.loaded());
    });
  }

  Future<void> _onGetClassifications(
      _GetClassifications event,
      Emitter<DashboardState> emit,
      ) async {
    advice = null;
    emit(const DashboardState.loading());
    final res = await _getClassifications.call(event.data);
    res.fold((failure) {
      emit(DashboardState.error(failure.message));
    }, (data) {
      logger.d('data $data');
      lastAdviceDate = event.data.date;
      advice = data;
      emit(const DashboardState.loaded());
    });
  }

  Future<void> _onGetForecast(
      _GetForecast event,
      Emitter<DashboardState> emit,
      ) async {
    forecast = null;
    emit(const DashboardState.loading());
    final res = await _getForecast.call(const None());
    res.fold((failure) {
      emit(DashboardState.error(failure.message));
    }, (data) {
      logger.d('forecast $data');
      forecast = data;
      emit(const DashboardState.loaded());
    });
  }
}
