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
