class ChildFoundException implements Exception {
  final String message;
  ChildFoundException(this.message);

  @override
  String toString() => 'ChildFoundException: $message';
}