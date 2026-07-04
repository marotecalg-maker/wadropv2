import 'package:flutter/material.dart';
import '../models/user_settings.dart';
import '../services/storage_service.dart';

/// Owns [UserSettings] and persists every change.
class SettingsProvider extends ChangeNotifier {
  final StorageService _storage;
  UserSettings _settings;

  SettingsProvider(this._storage)
      : _settings = _load(_storage);

  static UserSettings _load(StorageService storage) {
    final json = storage.readMap(StorageService.kSettings);
    return json == null ? const UserSettings() : UserSettings.fromJson(json);
  }

  UserSettings get settings => _settings;

  ThemeMode get themeMode => _settings.themeMode;

  /// `null` = follow the system locale.
  Locale? get locale =>
      _settings.localeCode == null ? null : Locale(_settings.localeCode!);

  Future<void> _persist(UserSettings next) async {
    _settings = next;
    notifyListeners();
    await _storage.writeMap(StorageService.kSettings, next.toJson());
  }

  Future<void> setGoal(int ml) =>
      _persist(_settings.copyWith(baseGoalMl: ml.clamp(500, 8000)));

  Future<void> setUnit(VolumeUnit unit) =>
      _persist(_settings.copyWith(unit: unit));

  Future<void> setThemeMode(ThemeMode mode) =>
      _persist(_settings.copyWith(themeMode: mode));

  Future<void> setLocale(String? code) =>
      _persist(_settings.copyWith(localeCode: code));

  Future<void> setWeight(double kg) =>
      _persist(_settings.copyWith(weightKg: kg.clamp(30, 250)));

  Future<void> setHeight(double cm) =>
      _persist(_settings.copyWith(heightCm: cm.clamp(120, 220)));

  Future<void> setStepGoal(int steps) =>
      _persist(_settings.copyWith(dailyStepGoal: steps.clamp(1000, 40000)));

  Future<void> setGender(Gender g) =>
      _persist(_settings.copyWith(gender: g));

  Future<void> setActivityLevel(ActivityLevel level) =>
      _persist(_settings.copyWith(activityLevel: level));

  Future<void> setRemindersEnabled(bool enabled) =>
      _persist(_settings.copyWith(remindersEnabled: enabled));

  Future<void> setReminderInterval(int hours) =>
      _persist(_settings.copyWith(reminderIntervalHours: hours.clamp(1, 6)));

  Future<void> setActiveHours(int from, int to) =>
      _persist(_settings.copyWith(activeFromHour: from, activeToHour: to));

  Future<void> resetToDefaults() => _persist(const UserSettings());
}
