/// Small date helpers used across providers and screens.
extension DateX on DateTime {
  DateTime get dayStart => DateTime(year, month, day);

  bool isSameDayAs(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Stable `yyyy-mm-dd` key for grouping and persistence.
  String get dayKey =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}

/// Returns the [count] most recent days (oldest first), each at day start.
List<DateTime> lastNDays(int count, {DateTime? from}) {
  final base = (from ?? DateTime.now()).dayStart;
  return List<DateTime>.generate(
    count,
    (i) => base.subtract(Duration(days: count - 1 - i)),
  );
}
