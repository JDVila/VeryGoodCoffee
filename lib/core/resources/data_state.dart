import 'package:meta/meta.dart';

@immutable
sealed class DataState<T> {
  const DataState({
    this.data,
    this.errorMessage,
  });
  final T? data;
  final String? errorMessage;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({
    required super.data,
    super.errorMessage,
  });
}

class DataFailure<T> extends DataState<T> {
  const DataFailure({
    super.errorMessage,
  });
}
