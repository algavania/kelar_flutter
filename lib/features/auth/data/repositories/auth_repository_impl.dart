import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kelar_flutter/features/auth/data/models/user_model.dart';
import 'package:kelar_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:kelar_flutter/utils/helper.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this.dataSource);

  final AuthRemoteDataSource dataSource;

  @override
  Future<Either<Failure, void>> login(String email, String password) {
    return safeCall(() => dataSource.login(email, password));
  }

  @override
  Future<Either<Failure, void>> register(UserModel user) {
    return safeCall(() => dataSource.register(user));
  }

  @override
  Future<Either<Failure, void>> logout() {
    return safeCall(dataSource.logout);
  }
}
