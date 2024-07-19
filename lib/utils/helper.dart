import 'package:dartz/dartz.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/utils/logger.dart';

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() operation) async {
  try {
    return Right(await operation());
  } catch (e, s) {
    logger.e('error', error: e.toString(), stackTrace: s);
    return Left(Failure(e.toString()));
  }
}

Either<Failure, T> safeCallSync<T>(T Function() operation) {
  try {
    return Right(operation());
  } catch (e, s) {
    logger.e('error', error: e.toString(), stackTrace: s);
    return Left(Failure(e.toString()));
  }
}


mixin UseCase<T, P> {
  Future<T> call(P params);
}

mixin UseCaseSync<T, P> {
  T call(P params);
}
