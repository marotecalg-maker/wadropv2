// Unit tests for Wadrop's core business logic (no plugins required).

import 'package:flutter_test/flutter_test.dart';
import 'package:wadrop/core/formatters.dart';
import 'package:wadrop/models/drink_entry.dart';
import 'package:wadrop/models/drink_type.dart';
import 'package:wadrop/models/user_settings.dart';
import 'package:wadrop/models/workout.dart';

void main() {
  group('Volume', () {
    test('formats millilitres', () {
      expect(Volume.format(330, VolumeUnit.ml), '330 ml');
    });

    test('converts and formats ounces', () {
      expect(Volume.format(500, VolumeUnit.oz), '16.9 oz');
    });

    test('round-trips through display units', () {
      final ml = Volume.fromDisplay(Volume.toDisplay(750, VolumeUnit.oz),
          VolumeUnit.oz);
      expect((ml - 750).abs() <= 1, isTrue);
    });
  });

  group('DrinkEntry hydration factor', () {
    test('water counts fully', () {
      final e = DrinkEntry(
          id: 'a', amountMl: 300, kind: DrinkKind.water, time: _t);
      expect(e.effectiveMl, 300);
    });

    test('coffee counts partially', () {
      final e = DrinkEntry(
          id: 'b', amountMl: 100, kind: DrinkKind.coffee, time: _t);
      expect(e.effectiveMl, closeTo(80, 0.001));
    });
  });

  group('UserSettings.suggestedGoal', () {
    test('scales with weight and activity', () {
      const s = UserSettings(
          weightKg: 80,
          gender: Gender.male,
          activityLevel: ActivityLevel.active);
      // 80 * 35 * 1.25 = 3500
      expect(s.suggestedGoalMl, 3500);
    });

    test('is clamped to a sane range', () {
      const s = UserSettings(weightKg: 30);
      expect(s.suggestedGoalMl >= 1200, isTrue);
    });
  });

  group('Walking distance', () {
    test('stride length scales with height and gender', () {
      const male = UserSettings(heightCm: 180, gender: Gender.male);
      // 180 * 0.415 / 100 = 0.747 m
      expect(male.strideMeters, closeTo(0.747, 0.001));

      const female = UserSettings(heightCm: 165, gender: Gender.female);
      // 165 * 0.413 / 100 = 0.68145 m
      expect(female.strideMeters, closeTo(0.6815, 0.001));
    });

    test('10,000 steps converts to a sensible km distance', () {
      const s = UserSettings(heightCm: 175, gender: Gender.male);
      final km = 10000 * s.strideMeters / 1000; // ~7.26 km
      expect(km, closeTo(7.26, 0.05));
    });
  });

  group('WorkoutEntry', () {
    test('estimates calories from MET, weight and duration', () {
      final w = WorkoutEntry(
        id: 'w',
        kind: WorkoutKind.running,
        intensity: WorkoutIntensity.medium,
        durationMin: 60,
        time: _t,
      );
      // 9.8 MET * 1.0 * 70kg * 1h = 686
      expect(w.caloriesFor(70), 686);
    });

    test('recommends extra water rounded to 10 ml', () {
      final w = WorkoutEntry(
        id: 'w',
        kind: WorkoutKind.strength,
        intensity: WorkoutIntensity.medium,
        durationMin: 45,
        time: _t,
      );
      // 8 ml/min * 1.0 * 45 = 360
      expect(w.extraWaterMl, 360);
      expect(w.extraWaterMl % 10, 0);
    });
  });
}

final DateTime _t = DateTime(2026, 1, 1, 10, 0);
