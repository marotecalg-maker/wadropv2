import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../models/drink_entry.dart';
import '../../models/favorite_drink.dart';
import '../../models/user_settings.dart';
import '../../providers/hydration_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/workout_provider.dart';
import '../../widgets/section_title.dart';
import '../../widgets/surface_card.dart';
import 'widgets/drink_picker_sheet.dart';
import 'widgets/favorites_bar.dart';
import 'widgets/stat_pill.dart';
import 'widgets/today_log_list.dart';
import 'widgets/water_globe.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final settings = context.watch<SettingsProvider>().settings;
    final hydration = context.watch<HydrationProvider>();
    final workout = context.watch<WorkoutProvider>();

    final unit = settings.unit;
    final baseGoal = settings.baseGoalMl;
    final bonus = workout.todayBonusMl;
    final effectiveGoal = baseGoal + bonus;

    final today = hydration.todayEffectiveMl;
    final progress = effectiveGoal == 0 ? 0.0 : today / effectiveGoal;
    final percent = (progress * 100).round();
    final left = (effectiveGoal - today).clamp(0.0, effectiveGoal.toDouble());
    final over = today - effectiveGoal;
    final streak = hydration.currentStreak(baseGoal);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: Row(
            children: [
              const Icon(Icons.water_drop_rounded, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(l.appName,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_greeting(l), style: theme.textTheme.titleMedium),
                Text(l.greetingSubtitle, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 16),

                // Summary pills
                Row(
                  children: [
                    Expanded(
                      child: StatPill(
                        emoji: '🔥',
                        value: '$streak',
                        label: l.dayStreak,
                        valueColor: streak > 0 ? AppColors.streak : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatPill(
                        emoji: '🥤',
                        value: '${hydration.cupsToday}',
                        label: l.cupsToday,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatPill(
                        emoji: '🎯',
                        value: '$percent%',
                        label: l.ofGoal,
                        valueColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Water globe
                Center(
                  child: WaterGlobe(
                    progress: progress,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$percent%',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 52,
                            color: AppColors.primaryBright,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${Volume.format(today, unit, withUnit: false)} / ${Volume.format(effectiveGoal, unit)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryBright
                                .withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Progress banner
                _Banner(
                  left: left,
                  over: over,
                  unit: unit,
                ),

                // Sport hydration hint
                if (bonus > 0) ...[
                  const SizedBox(height: 12),
                  _SportHint(bonusMl: bonus, unit: unit),
                ],
                const SizedBox(height: 28),

                // Favorites
                SectionTitle(
                  title: l.favorites,
                  emoji: '🥤',
                  trailing: IconButton.filledTonal(
                    onPressed: () => _addFavorite(context),
                    icon: const Icon(Icons.add_rounded),
                    tooltip: l.newFavorite,
                  ),
                ),
                const SizedBox(height: 12),
                FavoritesBar(
                  favorites: hydration.favorites,
                  unit: unit,
                  onTap: (fav) => _logFavorite(context, fav),
                  onLongPress: (fav) => _removeFavorite(context, fav),
                ),
                const SizedBox(height: 16),

                // Add / Undo
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => _addDrink(context),
                        icon: const Icon(Icons.add_rounded),
                        label: Text(l.addDrink),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: hydration.hasEntryToday
                            ? () => _undo(context)
                            : null,
                        icon: const Icon(Icons.undo_rounded),
                        label: Text(l.undo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Today's log
                SectionTitle(title: l.todaysLog, emoji: '📋'),
                const SizedBox(height: 12),
                TodayLogList(
                  entries: hydration.todayEntries,
                  unit: unit,
                  onDelete: (id) =>
                      context.read<HydrationProvider>().removeEntry(id),
                  onRepeat: (e) => _repeat(context, e),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _greeting(AppLocalizations l) {
    final h = DateTime.now().hour;
    if (h < 12) return l.greetingMorning;
    if (h < 17) return l.greetingAfternoon;
    if (h < 21) return l.greetingEvening;
    return l.greetingNight;
  }

  // ---- Actions --------------------------------------------------------------

  Future<void> _addDrink(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final result = await DrinkPickerSheet.show(
      context,
      title: l.addDrinkTitle,
      confirmLabel: l.add,
    );
    if (result == null || !context.mounted) return;
    HapticFeedback.lightImpact();
    await context
        .read<HydrationProvider>()
        .addDrink(result.$1, result.$2);
  }

  void _logFavorite(BuildContext context, FavoriteDrink fav) {
    HapticFeedback.lightImpact();
    context.read<HydrationProvider>().addFavoriteDrink(fav);
  }

  void _repeat(BuildContext context, DrinkEntry e) {
    HapticFeedback.lightImpact();
    context.read<HydrationProvider>().addDrink(e.amountMl, e.kind);
  }

  Future<void> _undo(BuildContext context) async {
    await context.read<HydrationProvider>().undoLast();
  }

  Future<void> _addFavorite(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final result = await DrinkPickerSheet.show(
      context,
      title: l.newFavorite,
      confirmLabel: l.save,
    );
    if (result == null || !context.mounted) return;
    await context
        .read<HydrationProvider>()
        .addFavorite(result.$1, result.$2);
  }

  Future<void> _removeFavorite(BuildContext context, FavoriteDrink fav) async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.editFavorites),
        content: Text(l.favoritesHint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.remove),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await context.read<HydrationProvider>().removeFavorite(fav.id);
    messenger.showSnackBar(SnackBar(content: Text(l.remove)));
  }
}

class _Banner extends StatelessWidget {
  final double left;
  final double over;
  final VolumeUnit unit;
  const _Banner({required this.left, required this.over, required this.unit});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final reached = left <= 0;

    final String text;
    if (over > 0) {
      text = l.overGoalBanner(Volume.format(over, unit));
    } else if (reached) {
      text = l.goalReachedBanner;
    } else {
      text = l.mlLeftToGoal(Volume.format(left, unit));
    }

    final color = reached ? AppColors.success : AppColors.primary;
    return SurfaceCard(
      color: color.withValues(alpha: 0.12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      child: Row(
        children: [
          Icon(reached ? Icons.emoji_events_rounded : Icons.water_drop_rounded,
              color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.titleMedium?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _SportHint extends StatelessWidget {
  final int bonusMl;
  final VolumeUnit unit;
  const _SportHint({required this.bonusMl, required this.unit});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SurfaceCard(
      color: AppColors.streak.withValues(alpha: 0.12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.fitness_center_rounded, color: AppColors.streak),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l.hydrationBonusDesc(Volume.format(bonusMl, unit)),
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
