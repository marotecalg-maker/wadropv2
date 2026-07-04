import 'drink_type.dart';

/// A single logged drink.
class DrinkEntry {
  final String id;
  final int amountMl;
  final DrinkKind kind;
  final DateTime time;

  const DrinkEntry({
    required this.id,
    required this.amountMl,
    required this.kind,
    required this.time,
  });

  /// Volume that actually counts toward the hydration goal.
  double get effectiveMl => amountMl * kind.hydrationFactor;

  Map<String, dynamic> toJson() => {
        'id': id,
        'amountMl': amountMl,
        'kind': kind.name,
        'time': time.toIso8601String(),
      };

  factory DrinkEntry.fromJson(Map<String, dynamic> j) => DrinkEntry(
        id: j['id'] as String,
        amountMl: (j['amountMl'] as num).toInt(),
        kind: DrinkKindX.fromName(j['kind']),
        time: DateTime.parse(j['time'] as String),
      );
}
