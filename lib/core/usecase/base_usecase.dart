import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/error/failure.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
