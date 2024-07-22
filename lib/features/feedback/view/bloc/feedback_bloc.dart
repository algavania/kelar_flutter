import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';
import 'package:kelar_flutter/features/feedback/domain/usecase/add_feedback.dart';
import 'package:kelar_flutter/features/feedback/domain/usecase/delete_feedback.dart';
import 'package:kelar_flutter/features/feedback/domain/usecase/get_feedbacks.dart';
import 'package:kelar_flutter/features/feedback/domain/usecase/update_feedback.dart';
import 'package:kelar_flutter/injector/injector.dart';
import 'package:kelar_flutter/utils/logger.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

part 'feedback_bloc.freezed.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(const FeedbackState.initial()) {
    on<_GetFeedbacks>(
      _onGetFeedbacks,
    );
    on<_AddFeedback>(
      _onAddFeedback,
    );
    on<_UpdateFeedback>(
      _onUpdateFeedback,
    );
    on<_DeleteFeedback>(
      _onDeleteFeedback,
    );
    on<_Reset>(
      _onReset,
    );
  }

  final _getFeedbacks = Injector.instance<GetFeedbacks>();
  final _addFeedback = Injector.instance<AddFeedback>();
  final _updateFeedback = Injector.instance<UpdateFeedback>();
  final _deleteFeedback = Injector.instance<DeleteFeedback>();
  Stream<List<FeedbackModel>>? feedbackStream;

  Future<void> _onReset(
    _Reset event,
    Emitter<FeedbackState> emit,
  ) async {
    feedbackStream = null;
    emit(const FeedbackState.initial());
  }

  Future<void> _onGetFeedbacks(
    _GetFeedbacks event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(const FeedbackState.loading());
    _getFeedbacks.call(const None()).fold((failure) {
      emit(FeedbackState.error(failure.message));
    }, (data) {
      logger.d('data $data');
      feedbackStream = data;
      emit(const FeedbackState.loaded());
    });
  }

  Future<void> _onAddFeedback(
    _AddFeedback event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(const FeedbackState.loading());
    final res = await _addFeedback.call(event.feedback);
    res.fold((failure) {
      emit(FeedbackState.error(failure.message));
    }, (_) {
      emit(const FeedbackState.added());
    });
  }

  Future<void> _onUpdateFeedback(
      _UpdateFeedback event,
      Emitter<FeedbackState> emit,
      ) async {
    emit(const FeedbackState.loading());
    final res = await _updateFeedback.call(event.feedback);
    res.fold((failure) {
      emit(FeedbackState.error(failure.message));
    }, (_) {
      emit(const FeedbackState.edited());
    });
  }

  Future<void> _onDeleteFeedback(
      _DeleteFeedback event,
      Emitter<FeedbackState> emit,
      ) async {
    emit(const FeedbackState.loading());
    final res = await _deleteFeedback.call(event.id);
    res.fold((failure) {
      emit(FeedbackState.error(failure.message));
    }, (_) {
      emit(const FeedbackState.deleted());
    });
  }
}
