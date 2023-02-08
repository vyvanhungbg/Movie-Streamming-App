class ApiError {
  final int? code;
  final String? message;

  ApiError({this.code, this.message});

  @override
  String toString() {
    return 'ApiError{code: $code, message: $message}';
  }
}
