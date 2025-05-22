class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}

// Example usage
// void main() {
//   try {
//     throw ServerException('Failed to connect to the server.');
//   } catch (e) {
//     print(e); // Output: ServerException: Failed to connect to the server.
//   }
// }