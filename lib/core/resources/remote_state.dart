import 'package:meta/meta.dart';

@immutable
sealed class RemoteState<T> {
  const RemoteState({
    this.data,
    this.errorMessage,
  });
  final T? data;
  final String? errorMessage;
}

class RemoteSuccess<T> extends RemoteState<T> {
  const RemoteSuccess({
    super.data,
    super.errorMessage,
  });
}

class RemoteFailServer extends RemoteState<void> {
  const RemoteFailServer({
    super.errorMessage,
  });
}

class RemoteFailClient extends RemoteState<void> {
  const RemoteFailClient({
    super.errorMessage,
  });
}

class RemoteFailRedirect<T> extends RemoteState<T> {
  const RemoteFailRedirect({
    super.data,
    super.errorMessage,
  });
}

class RemoteFailUnknown extends RemoteState<void> {
  const RemoteFailUnknown({
    super.errorMessage,
  });
}
