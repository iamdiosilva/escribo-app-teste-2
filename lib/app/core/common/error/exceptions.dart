class ServerException implements Exception {
  final String message;
  const ServerException(this.message);

}

class PermissionException implements Exception {
  final String message;
  const PermissionException(this.message);
}