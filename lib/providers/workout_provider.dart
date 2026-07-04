import 'package:flutter/foundation.dart';

import '../core/date_x.dart';
import '../models/workout.dart';
import '../services/storage_service.dart';

/// Owns all logged training sessions and the hydration bonus they generate.
class WorkoutProvider extends ChangeNotifier {
  final StorageService _storage;
  List<WorkoutEntry> _entries = [];

  WorkoutProvider(this._storage) {
    _entries = _storage
        .readList(StorageService.kWorkouts)
        .map(WorkoutEntry.fromJson)
        .toList();
  }

  // ---- Reads ----------------------------------------------------------------

  /// Today's sessions, newest first.
  List<WorkoutEntry> get todayEntries {
    final now = DateTime.now();
    final list = _entries.where((e) => e.time.isSameDayAs(now)).toList()
      ..sort((a, b) => b.time.compareTo(a.time));
    return list;
  }

  /// Extra water recommended today because of training.
  int get todayBonusMl =>
      todayEntries.fold(0, (sum, e) => sum + e.extraWaterMl);

  int get todayMinutes =>
      todayEntries.fold(0, (sum, e) => sum + e.durationMin);

  int get totalSessions => _entries.length;

  List<WorkoutEntry> entriesForDate(DateTime date) =>
      _entries.where((e) => e.time.isSameDayAs(date)).toList();

  List<WorkoutEntry> get thisWeek {
    final since = DateTime.now().dayStart.subtract(const Duration(days: 6));
    return _entries.where((e) => !e.time.dayStart.isBefore(since)).toList();
  }

  int get weekMinutes =>
      thisWeek.fold(0, (sum, e) => sum + e.durationMin);

  int weekCalories(double weightKg) =>
      thisWeek.fold(0, (sum, e) => sum + e.caloriesFor(weightKg));

  int get weekSessions => thisWeek.length;

  /// Minutes per weekday for the last 7 days (oldest first) — feeds the chart.
  List<int> weeklyMinutesSeries() {
    return lastNDays(7)
        .map((d) => entriesForDate(d).fold(0, (s, e) => s + e.durationMin))
        .toList();
  }

  // ---- Mutations ------------------------------------------------------------

  Future<void> addWorkout(
    WorkoutKind kind,
    WorkoutIntensity intensity,
    int durationMin, {
    DateTime? at,
  }) async {
    _entries.add(WorkoutEntry(
      id: '${DateTime.now().microsecondsSinceEpoch}_${_entries.length}',
      kind: kind,
      intensity: intensity,
      durationMin: durationMin,
      time: at ?? DateTime.now(),
    ));
    await _persist();
  }

  Future<void> removeEntry(String id) async {
    _entries.removeWhere((e) => e.id == id);
    await _persist();
  }

  /// Wipes all logged sessions.
  Future<void> clearAll() async {
    _entries = [];
    notifyListeners();
    await _storage.writeList(StorageService.kWorkouts, []);
  }

  Future<void> _persist() async {
    notifyListeners();
    await _storage.writeList(
        StorageService.kWorkouts, _entries.map((e) => e.toJson()).toList());
  }
}
