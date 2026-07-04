import 'package:flutter/material.dart';

enum VolumeUnit { ml, oz }

enum Gender { male, female, other }

enum ActivityLevel { sedentary, moderate, active }

/// All user-configurable preferences. Immutable — mutate through [copyWith].
@immutable
class UserSettings {
  final int baseGoalMl;
  final VolumeUnit unit;
  final ThemeMode themeMode;

  /// `null` means "follow the device language".
  final String? localeCode;

  final double weightKg;
  final double heightCm;
  final Gender gender;
  final ActivityLevel activityLevel;
  final int dailyStepGoal;

  final bool remindersEnabled;
  final int reminderIntervalHours;
  final int activeFromHour;
  final int activeToHour;

  const UserSettings({
    this.baseGoalMl = 2000,
    this.unit = VolumeUnit.ml,
    this.themeMode = ThemeMode.dark,
    this.localeCode,
    this.weightKg = 70,
    this.heightCm = 170,
    this.gender = Gender.male,
    this.activityLevel = ActivityLevel.moderate,
    this.dailyStepGoal = 8000,
    this.remindersEnabled = false,
    this.reminderIntervalHours = 2,
    this.activeFromHour = 8,
    this.activeToHour = 22,
  });

  /// Recommended daily intake derived from body weight, gender and activity.
  /// ~35 ml/kg baseline, nudged by activity and gender, rounded to 50 ml.
  int get suggestedGoalMl {
    double ml = weightKg * 35;
    ml *= switch (activityLevel) {
      ActivityLevel.sedentary => 1.0,
      ActivityLevel.moderate => 1.12,
      ActivityLevel.active => 1.25,
    };
    if (gender == Gender.female) ml *= 0.92;
    final rounded = (ml / 50).round() * 50;
    return rounded.clamp(1200, 5000);
  }

  /// Average step length in metres, estimated from height and gender.
  /// Used to convert a step count into a walking distance.
  double get strideMeters {
    final factor = gender == Gender.female ? 0.413 : 0.415;
    return (heightCm * factor) / 100;
  }

  UserSettings copyWith({
    int? baseGoalMl,
    VolumeUnit? unit,
    ThemeMode? themeMode,
    Object? localeCode = _sentinel,
    double? weightKg,
    double? heightCm,
    Gender? gender,
    ActivityLevel? activityLevel,
    int? dailyStepGoal,
    bool? remindersEnabled,
    int? reminderIntervalHours,
    int? activeFromHour,
    int? activeToHour,
  }) {
    return UserSettings(
      baseGoalMl: baseGoalMl ?? this.baseGoalMl,
      unit: unit ?? this.unit,
      themeMode: themeMode ?? this.themeMode,
      localeCode:
          localeCode == _sentinel ? this.localeCode : localeCode as String?,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      gender: gender ?? this.gender,
      activityLevel: activityLevel ?? this.activityLevel,
      dailyStepGoal: dailyStepGoal ?? this.dailyStepGoal,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      reminderIntervalHours:
          reminderIntervalHours ?? this.reminderIntervalHours,
      activeFromHour: activeFromHour ?? this.activeFromHour,
      activeToHour: activeToHour ?? this.activeToHour,
    );
  }

  Map<String, dynamic> toJson() => {
        'baseGoalMl': baseGoalMl,
        'unit': unit.name,
        'themeMode': themeMode.name,
        'localeCode': localeCode,
        'weightKg': weightKg,
        'heightCm': heightCm,
        'gender': gender.name,
        'activityLevel': activityLevel.name,
        'dailyStepGoal': dailyStepGoal,
        'remindersEnabled': remindersEnabled,
        'reminderIntervalHours': reminderIntervalHours,
        'activeFromHour': activeFromHour,
        'activeToHour': activeToHour,
      };

  factory UserSettings.fromJson(Map<String, dynamic> j) => UserSettings(
        baseGoalMl: (j['baseGoalMl'] as num?)?.toInt() ?? 2000,
        unit: _enumFrom(VolumeUnit.values, j['unit'], VolumeUnit.ml),
        themeMode: _enumFrom(ThemeMode.values, j['themeMode'], ThemeMode.dark),
        localeCode: j['localeCode'] as String?,
        weightKg: (j['weightKg'] as num?)?.toDouble() ?? 70,
        heightCm: (j['heightCm'] as num?)?.toDouble() ?? 170,
        gender: _enumFrom(Gender.values, j['gender'], Gender.male),
        activityLevel: _enumFrom(
            ActivityLevel.values, j['activityLevel'], ActivityLevel.moderate),
        dailyStepGoal: (j['dailyStepGoal'] as num?)?.toInt() ?? 8000,
        remindersEnabled: j['remindersEnabled'] as bool? ?? false,
        reminderIntervalHours:
            (j['reminderIntervalHours'] as num?)?.toInt() ?? 2,
        activeFromHour: (j['activeFromHour'] as num?)?.toInt() ?? 8,
        activeToHour: (j['activeToHour'] as num?)?.toInt() ?? 22,
      );

  static const Object _sentinel = Object();
}

T _enumFrom<T extends Enum>(List<T> values, Object? raw, T fallback) {
  for (final v in values) {
    if (v.name == raw) return v;
  }
  return fallback;
}
