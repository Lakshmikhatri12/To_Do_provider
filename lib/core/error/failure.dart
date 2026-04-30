abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure(String message) : super(message);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure(String message) : super(message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
