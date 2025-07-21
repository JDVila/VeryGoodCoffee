class RemoteResponse<T> {
  const RemoteResponse({
    this.data,
    this.statusCode,
    this.errorMessage,
  });
  final T? data;
  final int? statusCode;
  final String? errorMessage;
}
