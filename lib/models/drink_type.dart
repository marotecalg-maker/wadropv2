import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Kinds of drink the user can log. Each carries a hydration factor: how much
/// of its volume actually counts toward hydration (water = 1.0, coffee < 1.0).
enum DrinkKind {
  water,
  coffee,
  tea,
  juice,
  soda,
  milk,
  sparkling,
  energy,
}

extension DrinkKindX on DrinkKind {
  double get hydrationFactor => switch (this) {
        DrinkKind.water => 1.0,
        DrinkKind.sparkling => 1.0,
        DrinkKind.tea => 0.9,
        DrinkKind.milk => 0.9,
        DrinkKind.juice => 0.85,
        DrinkKind.soda => 0.85,
        DrinkKind.coffee => 0.8,
        DrinkKind.energy => 0.6,
      };

  IconData get icon => switch (this) {
        DrinkKind.water => Icons.water_drop_rounded,
        DrinkKind.coffee => Icons.coffee_rounded,
        DrinkKind.tea => Icons.emoji_food_beverage_rounded,
        DrinkKind.juice => Icons.local_bar_rounded,
        DrinkKind.soda => Icons.local_drink_rounded,
        DrinkKind.milk => Icons.icecream_rounded,
        DrinkKind.sparkling => Icons.bubble_chart_rounded,
        DrinkKind.energy => Icons.bolt_rounded,
      };

  Color get color => switch (this) {
        DrinkKind.water => const Color(0xFF4FA9F0),
        DrinkKind.coffee => const Color(0xFF9B6A43),
        DrinkKind.tea => const Color(0xFFC9A227),
        DrinkKind.juice => const Color(0xFFF4923B),
        DrinkKind.soda => const Color(0xFFE0556B),
        DrinkKind.milk => const Color(0xFFB9C4D6),
        DrinkKind.sparkling => const Color(0xFF56C4D6),
        DrinkKind.energy => const Color(0xFF7C5CFF),
      };

  String label(AppLocalizations l) => switch (this) {
        DrinkKind.water => l.drinkWater,
        DrinkKind.coffee => l.drinkCoffee,
        DrinkKind.tea => l.drinkTea,
        DrinkKind.juice => l.drinkJuice,
        DrinkKind.soda => l.drinkSoda,
        DrinkKind.milk => l.drinkMilk,
        DrinkKind.sparkling => l.drinkSparkling,
        DrinkKind.energy => l.drinkEnergy,
      };

  static DrinkKind fromName(Object? raw) => DrinkKind.values.firstWhere(
        (k) => k.name == raw,
        orElse: () => DrinkKind.water,
      );
}
