import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/date_x.dart';
import '../../core/formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../models/workout.dart';
import '../../providers/settings_provider.dart';
import '../../providers/workout_provider.dart';
import '../../widgets/section_title.dart';
import '../../widgets/surface_card.dart';
import 'widgets/add_workout_sheet.dart';
import 'widgets/steps_card.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>().settings;
    final workout = context.watch<WorkoutProvider>();
    final weight = settings.weightKg;

    return CustomScrollView(
      slivers: [
        SliverAppBar(pinned: true, title: Text(l.workoutTitle)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live step counter + walking distance
                const StepsCard(),
                const SizedBox(height: 16),

                // Hydration bonus banner
                SurfaceCard(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.water_drop_rounded,
                            color: AppColors.primary),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l.hydrationBonusTitle,
                                style: theme.textTheme.titleMedium),
                            const SizedBox(height: 2),
                            Text(
                              workout.todayBonusMl > 0
                                  ? l.hydrationBonusDesc(Volume.format(
                                      workout.todayBonusMl, settings.unit))
                                  : l.noWorkouts,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Weekly metrics
                SectionTitle(title: l.weeklyActivity, emoji: '📈'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _Metric(
                        icon: Icons.timer_rounded,
                        color: AppColors.primary,
                        value: '${workout.weekMinutes}',
                        label: l.activeMinutes,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Metric(
                        icon: Icons.local_fire_department_rounded,
                        color: AppColors.streak,
                        value: '${workout.weekCalories(weight)}',
                        label: l.caloriesLabel,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Metric(
                        icon: Icons.fitness_center_rounded,
                        color: AppColors.success,
                        value: '${workout.weekSessions}',
                        label: l.sessions,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Weekly minutes chart
                SurfaceCard(
                  padding: const EdgeInsets.fromLTRB(8, 20, 12, 8),
                  child: SizedBox(
                    height: 170,
                    child: _WeeklyChart(
                      minutes: workout.weeklyMinutesSeries(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                FilledButton.icon(
                  onPressed: () => _addWorkout(context),
                  icon: const Icon(Icons.add_rounded),
                  label: Text(l.addWorkout),
                ),
                const SizedBox(height: 24),

                SectionTitle(title: l.todaysWorkouts, emoji: '🏋️'),
                const SizedBox(height: 12),
                if (workout.todayEntries.isEmpty)
                  SurfaceCard(
                    padding: const EdgeInsets.symmetric(vertical: 26),
                    child: Center(
                      child: Text(l.noWorkouts,
                          style: theme.textTheme.bodyMedium),
                    ),
                  )
                else
                  for (final e in workout.todayEntries) ...[
                    _WorkoutRow(entry: e, weightKg: weight),
                    const SizedBox(height: 10),
                  ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addWorkout(BuildContext context) async {
    final result = await AddWorkoutSheet.show(context);
    if (result == null || !context.mounted) return;
    HapticFeedback.lightImpact();
    await context
        .read<WorkoutProvider>()
        .addWorkout(result.$1, result.$2, result.$3);
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _Metric({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: theme.textTheme.titleLarge),
          Text(label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}

class _WorkoutRow extends StatelessWidget {
  final WorkoutEntry entry;
  final double weightKg;

  const _WorkoutRow({required this.entry, required this.weightKg});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final unit = context.read<SettingsProvider>().settings.unit;

    return Dismissible(
      key: ValueKey(entry.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) =>
          context.read<WorkoutProvider>().removeEntry(entry.id),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: SurfaceCard(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: entry.kind.color.withValues(alpha: 0.18),
              child: Icon(entry.kind.icon, color: entry.kind.color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.kind.label(l)} · ${entry.durationMin} ${l.minutesShort}',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${entry.intensity.label(l)} · ${entry.caloriesFor(weightKg)} ${l.caloriesLabel}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                l.extraWater(Volume.format(entry.extraWaterMl, unit)),
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyChart extends StatelessWidget {
  final List<int> minutes;
  const _WeeklyChart({required this.minutes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final labelColor = theme.textTheme.labelMedium?.color ?? Colors.grey;
    final days = lastNDays(7);
    final maxVal =
        minutes.fold(0, (a, b) => a > b ? a : b).toDouble();
    final maxY = (maxVal <= 0 ? 60.0 : maxVal * 1.25) + 1;

    return BarChart(
      BarChartData(
        maxY: maxY,
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= days.length) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    DateFormat('E', locale).format(days[i]),
                    style: TextStyle(color: labelColor, fontSize: 10),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (int i = 0; i < minutes.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: minutes[i].toDouble(),
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.primary,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
