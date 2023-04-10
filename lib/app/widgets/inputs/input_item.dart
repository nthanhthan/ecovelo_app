class InputItem<T> {
  InputItem({
    required this.displayLabel,
    required this.id,
    this.value,
  });

  String displayLabel;
  String id;
  T? value;

  factory InputItem.empty() => InputItem(displayLabel: "", id: "");

  bool isEmpty() {
    return id.isEmpty;
  }

  bool isNotEmpty() {
    return id.isNotEmpty;
  }

  bool isMatched(InputItem? item) => item != null && item.id == id;
}
