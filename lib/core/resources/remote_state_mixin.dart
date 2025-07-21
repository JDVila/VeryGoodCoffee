import 'package:verygoodcoffee/core/resources/remote_response.dart';
import 'package:verygoodcoffee/core/resources/remote_state.dart';

mixin RemoteStateMixin<T> {
  RemoteState<dynamic> getRemoteState(RemoteResponse<T> response) {
    final statusCode = response.statusCode ?? -1;
    if (statusCode >= 200 && statusCode < 300) {
      return RemoteSuccess<T>(data: response.data);
    }
    if (statusCode >= 300 && statusCode < 400) {
      return RemoteFailRedirect<T>(
        data: response.data,
        errorMessage: response.errorMessage ?? 'Server Redirect',
      );
    }
    if (statusCode >= 400 && statusCode < 500) {
      return RemoteFailClient(
        errorMessage: response.errorMessage ?? 'Client Error',
      );
    }
    if (statusCode >= 500 && statusCode < 600) {
      return RemoteFailServer(
        errorMessage: response.errorMessage ?? 'Server Error',
      );
    }
    if (statusCode == -1) {
      return RemoteFailUnknown(
        errorMessage: response.errorMessage ?? 'Error Unknown',
      );
    }
    return RemoteFailUnknown(
      errorMessage: response.errorMessage ?? 'Error Unknown',
    );
  }
}
