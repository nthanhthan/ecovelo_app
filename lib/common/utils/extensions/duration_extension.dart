extension DurationConvertExtension on Duration {
  ///converts duration to HH:MM:SS format
  String toHHMMSS() => toString().split('.').first.padLeft(8, "0");

  ///converts duration to MM:SS format
  String toMMSS() =>
      '${(inMinutes.remainder(60)).toString().padLeft(2, '0')}:${(inSeconds.remainder(60)).toString().padLeft(2, '0')}';
}
