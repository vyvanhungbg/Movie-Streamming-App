import 'package:cinema/src/base/eror/api_error.dart';

abstract class DataState<T> {
  final T? data;
  final ApiError? error;

  const DataState({this.data, this.error});

  @override
  String toString() {
    return 'DataState{data: $data, error: $error}';
  }
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) :super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(ApiError error) :super(error: error);
}
