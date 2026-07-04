// Full-tree smoke test: builds the entire app (every screen/widget compiles
// through this path) and drives the bottom navigation across all five tabs.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wadrop/app.dart';
import 'package:wadrop/services/storage_service.dart';

void main() {
  testWidgets('app boots and every tab renders', (tester) async {
    // Phone-sized viewport so scrollable content is on-screen.
    tester.view.physicalSize = const Size(400, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({});
    final storage = await StorageService.create();

    await tester.pumpWidget(WadropApp(storage: storage));
    // Don't use pumpAndSettle — the water globe animates forever.
    await tester.pump(const Duration(milliseconds: 300));

    // Home tab shows the brand + default favourites.
    expect(find.text('Wadrop'), findsWidgets);
    expect(find.text('330'), findsWidgets); // 330 ml favourite

    // Tapping a favourite logs a drink and the cup count reacts.
    await tester.tap(find.text('150').first);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('1'), findsWidgets); // "1 cup today"

    // Visit each remaining destination.
    for (final icon in const [
      Icons.bar_chart_outlined,
      Icons.fitness_center_outlined,
      Icons.emoji_events_outlined,
      Icons.settings_outlined,
    ]) {
      await tester.tap(find.byIcon(icon));
      await tester.pump(const Duration(milliseconds: 300));
    }

    expect(tester.takeException(), isNull);
  });
}
