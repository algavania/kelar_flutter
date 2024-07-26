import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class LoginParams {
  LoginParams(this.email, this.password);

  final String email;
  final String password;
}

class Login implements UseCase<Either<Failure, void>, LoginParams> {
  Login(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(LoginParams params) {
    return _repository.login(params.email, params.password);
  }
}
