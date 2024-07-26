import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class Logout implements UseCase<Either<Failure, void>, None<void>> {
  Logout(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(None<void> params) {
    return _repository.logout();
  }
}
