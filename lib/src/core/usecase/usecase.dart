import 'package:dartz/dartz.dart';

import '../error/error.dart';

abstract interface class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}
