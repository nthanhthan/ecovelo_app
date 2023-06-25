class InputItem {
  InputItem({
    required this.displayLabel,
    required this.value,
    this.code,
    this.isDisable = false,
  });

  String displayLabel;
  String value;
  String? code;
  bool? isDisable;

  factory InputItem.empty() => InputItem(displayLabel: "", value: "");

  factory InputItem.fromJson(Map<String, dynamic> json) => InputItem(
        displayLabel: json["displayLabel"] == null ? "" : json["displayLabel"].toString(),
        value: json["value"] == null ? "" : json["value"].toString(),
        code: json["code"] == null ? "" : json["code"].toString(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "displayLabel": displayLabel,
        "value": value,
        "code": code,
      };

  bool isEmpty() {
    return value.isEmpty;
  }

  bool isNotEmpty() {
    return value.isNotEmpty;
  }
}
