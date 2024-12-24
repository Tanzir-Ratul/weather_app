class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;
  final int? statusCode;

  AppExceptions([this._message, this._prefix, this.statusCode]);

  @override
  String toString() {
    return '$_prefix$_message (Status Code: $statusCode)';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message, int? statusCode]) : super(message, 'No internet: ', statusCode);
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message, int? statusCode]) : super(message, 'Request Time out: ', statusCode);
}

class ServerException extends AppExceptions {
  ServerException(String message, [int? statusCode]) : super(message, 'Server Error: ', statusCode);

  @override
  String toString() => 'ServerException: $_message (Status Code: $statusCode)';
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message, int? statusCode]) : super(message, 'Invalid Url: ', statusCode);
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message, int? statusCode]) : super(message, 'Fetch Data Exception', statusCode);
}
class SSLHandshakeException extends AppExceptions {
  SSLHandshakeException([String? message, int? statusCode]) : super(message, 'SSL Handshake Exception', statusCode);
}
