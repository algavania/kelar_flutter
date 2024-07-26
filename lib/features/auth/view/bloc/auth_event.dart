part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.login(String email, String password) = _Login;
  const factory AuthEvent.register(UserModel user) = _Register;
  const factory AuthEvent.logout() = _Logout;
}
