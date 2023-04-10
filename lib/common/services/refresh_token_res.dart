enum RefreshTokenStatus {
  success,
  failed,
  cancel,
}

class RefreshTokenRes<T> {
  T? data;
  RefreshTokenStatus status;
  Map<String, dynamic>? authorizationHeader;
  RefreshTokenRes({
    this.data,
    required this.status,
    this.authorizationHeader,
  });
}
