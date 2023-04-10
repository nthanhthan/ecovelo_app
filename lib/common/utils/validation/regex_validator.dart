class RegVal {
  static bool hasMatch(String s, Pattern p) =>
      // ignore: unnecessary_null_comparison
      (s == null) ? false : RegExp(p.toString()).hasMatch(s);
}
