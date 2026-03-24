class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  String get message => _message ?? '';

  String toString() {
    return '$_prefix$_message';
  }
}

class fetchDataExceptions extends AppException {
  fetchDataExceptions([String? message])
    : super(message, 'Error during communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message])
    : super(message, 'Unauthorized request');
}

class InvalisInputException extends AppException {
  InvalisInputException([String? message]) : super(message, 'Invalid input');
}
