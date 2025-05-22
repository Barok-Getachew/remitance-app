class UserAlreadyExistsException implements Exception {
  final String message;
  UserAlreadyExistsException([this.message = "User already exists"]);

  @override
  String toString() => message;
}

class OneorMoreFieldIsInvalidException implements Exception {
  final String message;
  OneorMoreFieldIsInvalidException(
      [this.message =
          "Invalid input detected. Check the fields and try again."]);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  const CacheException(this.message);

  @override
  String toString() {
    return message;
  }
}
