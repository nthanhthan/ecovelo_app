extension NullSafeBlock<T> on T? {
  void ifNotNull(Function(T it) runnable) {
    final instance = this;
    if (instance != null) {
      runnable(instance);
    }
  }
}

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return '';
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NonNullNum on num? {
  num orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NonNullDouble on double? {
  num orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}
