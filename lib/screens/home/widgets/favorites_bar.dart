import 'package:flutter/material.dart';

import '../../../core/formatters.dart';
import '../../../models/drink_type.dart';
import '../../../models/favorite_drink.dart';
import '../../../models/user_settings.dart';
import '../../../widgets/surface_card.dart';

/// Grid of one-tap quick-add favourites (4 per row, wrapping).
class FavoritesBar extends StatelessWidget {
  final List<FavoriteDrink> favorites;
  final VolumeUnit unit;
  final void Function(FavoriteDrink) onTap;
  final void Function(FavoriteDrink) onLongPress;

  const FavoritesBar({
    super.key,
    required this.favorites,
    required this.unit,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final tileWidth = (constraints.maxWidth - spacing * 3) / 4;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: favorites.map((fav) {
            return SizedBox(
              width: tileWidth,
              child: _FavoriteTile(
                fav: fav,
                unit: unit,
                onTap: () => onTap(fav),
                onLongPress: () => onLongPress(fav),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  final FavoriteDrink fav;
  final VolumeUnit unit;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _FavoriteTile({
    required this.fav,
    required this.unit,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SurfaceCard(
      onTap: onTap,
      onLongPress: onLongPress,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
      child: Column(
        children: [
          Icon(fav.kind.icon, color: fav.kind.color, size: 30),
          const SizedBox(height: 8),
          Text(
            Volume.format(fav.amountMl, unit, withUnit: false),
            style: theme.textTheme.titleMedium,
          ),
          Text(Volume.unitLabel(unit), style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}
