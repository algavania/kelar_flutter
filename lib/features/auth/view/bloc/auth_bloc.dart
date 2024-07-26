import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelar_flutter/features/auth/data/models/user_model.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/login.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/logout.dart';
import 'package:kelar_flutter/features/auth/domain/usecases/register.dart';
import 'package:kelar_flutter/injector/injector.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<_Login>(
      _onLogin,
    );
    on<_Logout>(
      _onLogout,
    );
    on<_Register>(
      _onRegister,
    );
  }

  final _login = Injector.instance<Login>();
  final _logout = Injector.instance<Logout>();
  final _register = Injector.instance<Register>();

  Future<void> _onRegister(
      _Register event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthState.loading());
    final res = await _register.call(event.user);
    res.fold((failure) {
      emit(AuthState.error(failure.message));
    }, (_) {
      emit(const AuthState.loggedIn());
    });
  }

  Future<void> _onLogin(
    _Login event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final res = await _login.call(LoginParams(event.email, event.password));
    res.fold((failure) {
      emit(AuthState.error(failure.message));
    }, (_) {
      emit(const AuthState.loggedIn());
    });
  }

  Future<void> _onLogout(
    _Logout event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final res = await _logout.call(const None());
    res.fold((failure) {
      emit(AuthState.error(failure.message));
    }, (_) {
      emit(const AuthState.loggedOut());
    });
  }
}
