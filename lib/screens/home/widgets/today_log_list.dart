import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/drink_entry.dart';
import '../../../models/drink_type.dart';
import '../../../models/user_settings.dart';
import '../../../widgets/surface_card.dart';

/// The "Today's log" list. Swipe a row to delete; tap the repeat icon to log
/// the same drink again.
class TodayLogList extends StatelessWidget {
  final List<DrinkEntry> entries;
  final VolumeUnit unit;
  final void Function(String id) onDelete;
  final void Function(DrinkEntry entry) onRepeat;

  const TodayLogList({
    super.key,
    required this.entries,
    required this.unit,
    required this.onDelete,
    required this.onRepeat,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    if (entries.isEmpty) {
      return SurfaceCard(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        child: Column(
          children: [
            Icon(Icons.local_drink_outlined,
                size: 40, color: theme.textTheme.labelMedium?.color),
            const SizedBox(height: 10),
            Text(l.emptyLogTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(l.emptyLogSubtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium),
          ],
        ),
      );
    }

    return Column(
      children: [
        for (final e in entries) ...[
          Dismissible(
            key: ValueKey(e.id),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => onDelete(e.id),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.delete_outline_rounded,
                  color: Colors.white),
            ),
            child: SurfaceCard(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: e.kind.color.withValues(alpha: 0.18),
                    child: Icon(e.kind.icon, color: e.kind.color),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Volume.format(e.amountMl, unit)} · ${e.kind.label(l)}',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          TimeOfDay.fromDateTime(e.time).format(context),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: l.addDrink,
                    onPressed: () => onRepeat(e),
                    icon: Icon(Icons.replay_rounded,
                        color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
