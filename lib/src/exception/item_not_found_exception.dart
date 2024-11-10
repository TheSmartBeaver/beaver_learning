class ItemNotFoundException implements Exception {
  final String message;
  ItemNotFoundException(this.message);

  @override
  String toString() => 'ItemNotFoundException: $message';
}