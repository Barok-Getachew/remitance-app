class ServerException implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  String toString() {
    return message;
  }
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() {
    return message;
  }
}

class CacheException implements Exception {
  final String message;

  const CacheException(this.message);

  @override
  String toString() {
    return message;
  }
}
