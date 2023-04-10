import 'package:collection/collection.dart';

extension NullableList on List<dynamic>? {
  bool get isListNullOrEmpty {
    return this == null || (this?.isEmpty ?? true);
  }

  bool get hasItem {
    return this != null && (this?.isNotEmpty ?? false);
  }
}

extension ListParsing on List<dynamic> {
  List<T> clone<T>() {
    return List<T>.from(this);
  }

  bool isContains<T>(bool Function(T) compare) {
    return firstWhereOrNull((dynamic e) => compare(e as T)) != null;
  }
  bool hasSameItem<T>(List<T> other) {
    if (length != other.length) return false;
    return !other.any((dynamic element) => !contains(element));
  }
}

extension IterableExt<T> on Iterable<T> {
  Iterable<T> widgetJoin(T separator) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return [];

    final _l = [iterator.current];
    while (iterator.moveNext()) {
      _l
        ..add(separator)
        ..add(iterator.current);
    }
    return _l;
  }
}
