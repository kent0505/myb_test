abstract class AuthResult {}

class RegisteredResult extends AuthResult {
  final bool registered;
  RegisteredResult(this.registered);
}

class SuccessResult extends AuthResult {
  final String token;
  SuccessResult(this.token);
}

class ErrorResult extends AuthResult {}

class CodeResult extends AuthResult {
  final int code;
  final bool registered;
  CodeResult(
    this.code,
    this.registered,
  );
}

class ExceptionResult extends AuthResult {
  final String error;
  ExceptionResult(this.error);
}
