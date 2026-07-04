import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'providers/hydration_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/steps_provider.dart';
import 'providers/workout_provider.dart';
import 'screens/root_scaffold.dart';
import 'services/storage_service.dart';

class WadropApp extends StatelessWidget {
  final StorageService storage;
  const WadropApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider(storage)),
        ChangeNotifierProvider(create: (_) => HydrationProvider(storage)),
        ChangeNotifierProvider(create: (_) => WorkoutProvider(storage)),
        ChangeNotifierProvider(create: (_) => StepsProvider(storage)..start()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Wadrop',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: settings.themeMode,
            locale: settings.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const RootScaffold(),
          );
        },
      ),
    );
  }
}
