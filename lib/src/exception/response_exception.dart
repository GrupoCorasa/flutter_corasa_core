class ResponseException implements Exception {
  final String? message;
  final List<String>? details;

  const ResponseException({this.message, this.details});
}
