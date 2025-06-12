// Data
class ServerExceptions implements Exception {}

class CacheException implements Exception {}

// Route
class RouterException implements Exception {
  final String message;

  const RouterException(this.message);
}