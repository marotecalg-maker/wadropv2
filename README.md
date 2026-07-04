# 💧 Wadrop

A professional water-intake & fitness-hydration tracker built with Flutter.

Track how much water you drink, hit a personalized daily goal, keep streaks,
earn achievements, and log your sport sessions — which automatically raise the
amount of water your body needs that day.

## Features

- **Animated water globe** — live dual-wave fill showing today's progress.
- **Quick-add favourites** — one-tap logging (150 / 200 / 330 / 500 ml by
  default); add, edit and remove your own.
- **Smart hydration** — each drink type has a hydration factor (water = 100 %,
  coffee = 80 %, …) so the goal reflects *effective* hydration.
- **Sport & fitness module** — log strength (musculation), cardio, running,
  cycling, swimming, yoga, walking, HIIT or football with intensity & duration.
  Each session estimates calories burned and adds a **hydration bonus** to your
  daily goal.
- **Step counter & walking distance** — reads the phone's pedometer, converts
  steps into **distance (km)** using a stride length derived from your height &
  gender, estimates calories, and tracks progress toward a daily step goal.
- **Statistics** — weekly/monthly bar charts, daily average, goal completion,
  days-met, and an intake-by-drink breakdown (powered by `fl_chart`).
- **Achievements** — streaks, badges and lifetime stats.
- **Dark / Light / System themes** — dark-first design.
- **3 languages** — English, Français, العربية (with full right-to-left layout).
- **Reminders** — configurable interval and active hours (persisted).
- **Profile-based goal suggestion** — from weight, gender and activity level.
- **Offline-first** — everything is stored locally via `shared_preferences`.

## Project structure

```
lib/
├── main.dart                 # Bootstrap (loads storage, runs the app)
├── app.dart                  # MaterialApp + providers + theme + i18n
├── core/                     # Colours, theme, formatters, date helpers
├── l10n/                     # app_en.arb / app_fr.arb / app_ar.arb (+ generated)
├── models/                   # DrinkEntry, DrinkKind, Workout, UserSettings…
├── services/                 # StorageService (SharedPreferences wrapper)
├── providers/                # Settings / Hydration / Workout (ChangeNotifier)
├── widgets/                  # Shared UI (background, cards, section titles)
└── screens/
    ├── root_scaffold.dart    # Bottom navigation host
    ├── home/                 # Globe, favourites, add-drink, today's log
    ├── stats/                # Charts & metrics
    ├── workout/              # Sport logging + weekly activity
    ├── awards/               # Streaks & badges
    └── settings/             # Goal, units, profile, theme, language, reminders
```

State management: **Provider**. Persistence: **SharedPreferences** (JSON).
Localization: **flutter gen-l10n** (`.arb` files).
Steps: **pedometer** + **permission_handler** (needs `ACTIVITY_RECOGNITION` on
Android / `NSMotionUsageDescription` on iOS — both already declared). The step
sensor only exists on real Android/iOS devices; on desktop/web/tests the counter
degrades gracefully to 0.

## Running

```bash
flutter pub get
flutter run          # pick a device (Android/iOS emulator or physical)
```

Regenerate localizations after editing an `.arb` file:

```bash
flutter gen-l10n
```

Run the tests:

```bash
flutter test
```

### Building for Android

```bash
flutter build apk            # or: flutter build appbundle
```

> **Windows desktop note:** if the project lives on a different drive than the
> Flutter SDK, `flutter pub get` can't create the plugin symlinks for the
> Windows desktop target (a harmless `ERROR_INVALID_FUNCTION` warning). This
> does **not** affect Android, iOS or web builds. To build for Windows desktop,
> move the project onto the same drive as the SDK.

## Ideas for later

- Real local notifications (add `flutter_local_notifications` + wire
  `SettingsProvider` reminder fields).
- Cloud sync / backup.
- Home-screen widget & wearable companion.
