import 'package:flutter/foundation.dart';

import '../core/date_x.dart';
import '../models/drink_entry.dart';
import '../models/drink_type.dart';
import '../models/favorite_drink.dart';
import '../services/storage_service.dart';

/// A single day's aggregate, used by the stats screen.
class DailyTotal {
  final DateTime date;
  final double effectiveMl;
  final bool metGoal;
  const DailyTotal(this.date, this.effectiveMl, this.metGoal);
}

/// Owns all drink entries and favourites. Streaks and history are computed
/// against the *base* goal passed in by the caller (see [SettingsProvider]).
class HydrationProvider extends ChangeNotifier {
  final StorageService _storage;

  List<DrinkEntry> _entries = [];
  List<FavoriteDrink> _favorites = [];

  HydrationProvider(this._storage) {
    _entries = _storage
        .readList(StorageService.kEntries)
        .map(DrinkEntry.fromJson)
        .toList();
    _favorites = _storage.contains(StorageService.kFavorites)
        ? _storage
            .readList(StorageService.kFavorites)
            .map(FavoriteDrink.fromJson)
            .toList()
        : FavoriteDrink.defaults();
  }

  // ---- Reads ----------------------------------------------------------------

  List<FavoriteDrink> get favorites => List.unmodifiable(_favorites);

  /// Today's entries, newest first.
  List<DrinkEntry> get todayEntries {
    final now = DateTime.now();
    final list = _entries.where((e) => e.time.isSameDayAs(now)).toList()
      ..sort((a, b) => b.time.compareTo(a.time));
    return list;
  }

  /// Hydration counted toward the goal today (respects hydration factors).
  double get todayEffectiveMl =>
      todayEntries.fold(0.0, (sum, e) => sum + e.effectiveMl);

  int get cupsToday => todayEntries.length;

  bool get hasEntryToday => todayEntries.isNotEmpty;

  double effectiveForDate(DateTime date) => _entries
      .where((e) => e.time.isSameDayAs(date))
      .fold(0.0, (sum, e) => sum + e.effectiveMl);

  int get lifetimeMl => _entries.fold(0, (sum, e) => sum + e.amountMl);

  int get daysTracked => _entries.map((e) => e.time.dayKey).toSet().length;

  int get totalEntries => _entries.length;

  /// Consecutive days (ending today, or yesterday if today isn't met yet)
  /// that reached [goalMl].
  int currentStreak(int goalMl) {
    bool met(DateTime d) => effectiveForDate(d) >= goalMl;
    final today = DateTime.now().dayStart;
    DateTime cursor = met(today) ? today : today.subtract(const Duration(days: 1));
    int streak = 0;
    while (met(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Longest streak ever recorded for the given goal.
  int bestStreak(int goalMl) {
    if (_entries.isEmpty) return 0;
    bool met(DateTime d) => effectiveForDate(d) >= goalMl;
    DateTime earliest = _entries.first.time.dayStart;
    for (final e in _entries) {
      final d = e.time.dayStart;
      if (d.isBefore(earliest)) earliest = d;
    }
    final today = DateTime.now().dayStart;
    int best = 0, run = 0;
    for (DateTime d = earliest;
        !d.isAfter(today);
        d = d.add(const Duration(days: 1))) {
      if (met(d)) {
        run++;
        if (run > best) best = run;
      } else {
        run = 0;
      }
    }
    // Persist the personal best so it survives log trimming.
    final stored = _storage.readInt(StorageService.kBestStreak);
    if (best > stored) {
      _storage.writeInt(StorageService.kBestStreak, best);
      return best;
    }
    return stored;
  }

  /// Aggregated daily totals for the last [days] days, oldest first.
  List<DailyTotal> history(int days, int goalMl) {
    return lastNDays(days)
        .map((d) => DailyTotal(
              d,
              effectiveForDate(d),
              effectiveForDate(d) >= goalMl,
            ))
        .toList();
  }

  int daysMetGoalIn(int days, int goalMl) =>
      history(days, goalMl).where((d) => d.metGoal).length;

  /// Total volume per drink kind over the last [days] days.
  Map<DrinkKind, double> intakeByKind(int days) {
    final since = DateTime.now().dayStart.subtract(Duration(days: days - 1));
    final map = <DrinkKind, double>{};
    for (final e in _entries) {
      if (e.time.isBefore(since)) continue;
      map[e.kind] = (map[e.kind] ?? 0) + e.amountMl;
    }
    return map;
  }

  // ---- Mutations ------------------------------------------------------------

  Future<void> addDrink(int amountMl, DrinkKind kind, {DateTime? at}) async {
    _entries.add(DrinkEntry(
      id: _newId(),
      amountMl: amountMl,
      kind: kind,
      time: at ?? DateTime.now(),
    ));
    await _persistEntries();
  }

  Future<void> addFavoriteDrink(FavoriteDrink fav) =>
      addDrink(fav.amountMl, fav.kind);

  /// Removes the most recently logged entry (the last "add" action).
  Future<void> undoLast() async {
    if (_entries.isEmpty) return;
    DrinkEntry latest = _entries.first;
    for (final e in _entries) {
      if (e.time.isAfter(latest.time)) latest = e;
    }
    _entries.remove(latest);
    await _persistEntries();
  }

  Future<void> removeEntry(String id) async {
    _entries.removeWhere((e) => e.id == id);
    await _persistEntries();
  }

  Future<void> resetToday() async {
    final now = DateTime.now();
    _entries.removeWhere((e) => e.time.isSameDayAs(now));
    await _persistEntries();
  }

  /// Wipes all logged drinks and restores the default favourites.
  Future<void> clearAll() async {
    _entries = [];
    _favorites = FavoriteDrink.defaults();
    notifyListeners();
    await _storage.writeList(StorageService.kEntries, []);
    await _storage.writeInt(StorageService.kBestStreak, 0);
    await _persistFavorites();
  }

  // ---- Favourites -----------------------------------------------------------

  Future<void> addFavorite(int amountMl, DrinkKind kind) async {
    _favorites.add(FavoriteDrink(id: _newId(), amountMl: amountMl, kind: kind));
    await _persistFavorites();
  }

  Future<void> updateFavorite(FavoriteDrink fav) async {
    final i = _favorites.indexWhere((f) => f.id == fav.id);
    if (i != -1) {
      _favorites[i] = fav;
      await _persistFavorites();
    }
  }

  Future<void> removeFavorite(String id) async {
    _favorites.removeWhere((f) => f.id == id);
    await _persistFavorites();
  }

  // ---- Internals ------------------------------------------------------------

  Future<void> _persistEntries() async {
    notifyListeners();
    await _storage.writeList(
        StorageService.kEntries, _entries.map((e) => e.toJson()).toList());
  }

  Future<void> _persistFavorites() async {
    notifyListeners();
    await _storage.writeList(
        StorageService.kFavorites, _favorites.map((f) => f.toJson()).toList());
  }

  String _newId() =>
      '${DateTime.now().microsecondsSinceEpoch}_${_entries.length}';
}
