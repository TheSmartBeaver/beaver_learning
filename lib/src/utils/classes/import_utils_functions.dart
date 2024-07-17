bool fileCanBeReadAsString(String filePath) {
  List<String> paths = filePath.split('/');
  if ((filePath.contains(".json") ||
          filePath.contains(".html") ||
          filePath.contains(".css") ||
          filePath.contains(".js") ||
          filePath.contains(".txt") ||
          filePath.contains(".md") ||
          filePath.contains(".csv") ||
          filePath.contains(".xml")) &&
      paths[paths.length - 1].contains('.') &&
      !paths[paths.length - 1].startsWith('.')) {
    return true;
  }
  return false;
}

String extractParentFolder(String fullPath) {
  List<String> paths = fullPath.split('/');
  return fullPath.substring(
      0, fullPath.length - paths[paths.length - 1].length - 1);
}