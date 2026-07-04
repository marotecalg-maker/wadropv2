import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../widgets/app_background.dart';
import 'awards/awards_screen.dart';
import 'home/home_screen.dart';
import 'settings/settings_screen.dart';
import 'stats/stats_screen.dart';
import 'workout/workout_screen.dart';

/// Hosts the five main tabs and the persistent bottom navigation bar.
class RootScaffold extends StatefulWidget {
  const RootScaffold({super.key});

  @override
  State<RootScaffold> createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<RootScaffold> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    StatsScreen(),
    WorkoutScreen(),
    AwardsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: IndexedStack(index: _index, children: _screens),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: l.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart_rounded),
            label: l.navStats,
          ),
          NavigationDestination(
            icon: const Icon(Icons.fitness_center_outlined),
            selectedIcon: const Icon(Icons.fitness_center_rounded),
            label: l.navWorkout,
          ),
          NavigationDestination(
            icon: const Icon(Icons.emoji_events_outlined),
            selectedIcon: const Icon(Icons.emoji_events_rounded),
            label: l.navAwards,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings_rounded),
            label: l.navSettings,
          ),
        ],
      ),
    );
  }
}
