class ServerException implements Exception {
  final String message;
  final String? statusCode;
  final String? errorCode;

  ServerException({
    required this.message,
    this.statusCode,
    this.errorCode,
  });
}
