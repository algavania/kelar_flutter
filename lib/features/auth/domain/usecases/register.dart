import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/auth/data/models/user_model.dart';
import 'package:kelar_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class Register implements UseCase<Either<Failure, void>, UserModel> {
  Register(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(UserModel params) {
    return _repository.register(params);
  }
}
