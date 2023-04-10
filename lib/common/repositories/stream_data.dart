class StreamData<T> {
  T? data;
  StreamStatus? status;
  StreamData({this.data, this.status});
}

class StreamStatus {
  final bool isStreaming;
  final bool isError;
  final bool isCompleted;
  final bool isEmpty;
  final bool isStreamMore;
  final String? errorMessage;

  StreamStatus._({
    this.isEmpty = false,
    this.isStreaming = false,
    this.isError = false,
    this.isCompleted = false,
    this.errorMessage = "",
    this.isStreamMore = false,
  });

  factory StreamStatus.streaming() {
    return StreamStatus._(isStreaming: true);
  }

  factory StreamStatus.streamMore() {
    return StreamStatus._(isCompleted: false, isStreamMore: true);
  }

  factory StreamStatus.completed() {
    return StreamStatus._(isCompleted: true, isStreaming: false);
  }

  factory StreamStatus.error([String? message]) {
    return StreamStatus._(isError: true, errorMessage: message);
  }

  factory StreamStatus.empty() {
    return StreamStatus._(isEmpty: true);
  }
}
