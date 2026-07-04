import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Sport activities. Each has a MET value (metabolic equivalent) used for
/// calorie estimation and a base sweat rate used for the hydration bonus.
enum WorkoutKind {
  strength,
  cardio,
  running,
  cycling,
  swimming,
  yoga,
  walking,
  hiit,
  football,
}

enum WorkoutIntensity { low, medium, high }

extension WorkoutIntensityX on WorkoutIntensity {
  /// Scales both calories and sweat loss.
  double get factor => switch (this) {
        WorkoutIntensity.low => 0.8,
        WorkoutIntensity.medium => 1.0,
        WorkoutIntensity.high => 1.2,
      };

  String label(AppLocalizations l) => switch (this) {
        WorkoutIntensity.low => l.intensityLow,
        WorkoutIntensity.medium => l.intensityMedium,
        WorkoutIntensity.high => l.intensityHigh,
      };

  static WorkoutIntensity fromName(Object? raw) =>
      WorkoutIntensity.values.firstWhere(
        (v) => v.name == raw,
        orElse: () => WorkoutIntensity.medium,
      );
}

extension WorkoutKindX on WorkoutKind {
  /// Metabolic equivalent of task at moderate intensity.
  double get met => switch (this) {
        WorkoutKind.strength => 5.0,
        WorkoutKind.cardio => 7.0,
        WorkoutKind.running => 9.8,
        WorkoutKind.cycling => 7.5,
        WorkoutKind.swimming => 8.0,
        WorkoutKind.yoga => 3.0,
        WorkoutKind.walking => 3.5,
        WorkoutKind.hiit => 9.0,
        WorkoutKind.football => 8.0,
      };

  /// Base fluid loss per minute (ml) at moderate intensity.
  double get sweatMlPerMin => switch (this) {
        WorkoutKind.strength => 8,
        WorkoutKind.cardio => 11,
        WorkoutKind.running => 14,
        WorkoutKind.cycling => 12,
        WorkoutKind.swimming => 9,
        WorkoutKind.yoga => 5,
        WorkoutKind.walking => 6,
        WorkoutKind.hiit => 15,
        WorkoutKind.football => 13,
      };

  IconData get icon => switch (this) {
        WorkoutKind.strength => Icons.fitness_center_rounded,
        WorkoutKind.cardio => Icons.favorite_rounded,
        WorkoutKind.running => Icons.directions_run_rounded,
        WorkoutKind.cycling => Icons.directions_bike_rounded,
        WorkoutKind.swimming => Icons.pool_rounded,
        WorkoutKind.yoga => Icons.self_improvement_rounded,
        WorkoutKind.walking => Icons.directions_walk_rounded,
        WorkoutKind.hiit => Icons.timer_rounded,
        WorkoutKind.football => Icons.sports_soccer_rounded,
      };

  Color get color => switch (this) {
        WorkoutKind.strength => const Color(0xFFF0654F),
        WorkoutKind.cardio => const Color(0xFFFF7A3D),
        WorkoutKind.running => const Color(0xFF46D6A0),
        WorkoutKind.cycling => const Color(0xFF4FA9F0),
        WorkoutKind.swimming => const Color(0xFF56C4D6),
        WorkoutKind.yoga => const Color(0xFFB07CFF),
        WorkoutKind.walking => const Color(0xFF7FB77E),
        WorkoutKind.hiit => const Color(0xFFF5B14C),
        WorkoutKind.football => const Color(0xFF63C29A),
      };

  String label(AppLocalizations l) => switch (this) {
        WorkoutKind.strength => l.workoutStrength,
        WorkoutKind.cardio => l.workoutCardio,
        WorkoutKind.running => l.workoutRunning,
        WorkoutKind.cycling => l.workoutCycling,
        WorkoutKind.swimming => l.workoutSwimming,
        WorkoutKind.yoga => l.workoutYoga,
        WorkoutKind.walking => l.workoutWalking,
        WorkoutKind.hiit => l.workoutHiit,
        WorkoutKind.football => l.workoutFootball,
      };

  static WorkoutKind fromName(Object? raw) => WorkoutKind.values.firstWhere(
        (k) => k.name == raw,
        orElse: () => WorkoutKind.strength,
      );
}

/// A single logged training session.
class WorkoutEntry {
  final String id;
  final WorkoutKind kind;
  final WorkoutIntensity intensity;
  final int durationMin;
  final DateTime time;

  const WorkoutEntry({
    required this.id,
    required this.kind,
    required this.intensity,
    required this.durationMin,
    required this.time,
  });

  /// Estimated calories burned given the user's body weight.
  int caloriesFor(double weightKg) =>
      (kind.met * intensity.factor * weightKg * (durationMin / 60.0)).round();

  /// Extra water (ml) recommended to offset sweat loss from this session,
  /// rounded to the nearest 10 ml.
  int get extraWaterMl {
    final raw = kind.sweatMlPerMin * intensity.factor * durationMin;
    return (raw / 10).round() * 10;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kind': kind.name,
        'intensity': intensity.name,
        'durationMin': durationMin,
        'time': time.toIso8601String(),
      };

  factory WorkoutEntry.fromJson(Map<String, dynamic> j) => WorkoutEntry(
        id: j['id'] as String,
        kind: WorkoutKindX.fromName(j['kind']),
        intensity: WorkoutIntensityX.fromName(j['intensity']),
        durationMin: (j['durationMin'] as num).toInt(),
        time: DateTime.parse(j['time'] as String),
      );
}
