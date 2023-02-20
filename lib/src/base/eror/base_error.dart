class BaseError {
  final int? code;
  final String? message;

  BaseError({this.code, this.message});

  @override
  String toString() {
    return 'ApiError{code: $code, message: $message}';
  }
}
