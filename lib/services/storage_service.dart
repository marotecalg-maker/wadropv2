import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Thin, synchronous-read wrapper over [SharedPreferences].
///
/// Call [create] once at startup so the rest of the app can read cached
/// values without awaiting.
class StorageService {
  final SharedPreferences _prefs;
  StorageService(this._prefs);

  static Future<StorageService> create() async =>
      StorageService(await SharedPreferences.getInstance());

  static const kEntries = 'wadrop.entries';
  static const kFavorites = 'wadrop.favorites';
  static const kWorkouts = 'wadrop.workouts';
  static const kSettings = 'wadrop.settings';
  static const kBestStreak = 'wadrop.bestStreak';
  static const kSteps = 'wadrop.steps';

  bool contains(String key) => _prefs.containsKey(key);

  List<Map<String, dynamic>> readList(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded.cast<Map<String, dynamic>>();
    } catch (_) {
      return [];
    }
  }

  Future<void> writeList(String key, List<Map<String, dynamic>> value) =>
      _prefs.setString(key, jsonEncode(value));

  Map<String, dynamic>? readMap(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> writeMap(String key, Map<String, dynamic> value) =>
      _prefs.setString(key, jsonEncode(value));

  int readInt(String key, {int fallback = 0}) =>
      _prefs.getInt(key) ?? fallback;

  Future<void> writeInt(String key, int value) => _prefs.setInt(key, value);

  Future<void> clearAll() async {
    await _prefs.remove(kEntries);
    await _prefs.remove(kFavorites);
    await _prefs.remove(kWorkouts);
    await _prefs.remove(kSettings);
    await _prefs.remove(kBestStreak);
    await _prefs.remove(kSteps);
  }
}
