import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../models/drink_type.dart';
import '../../models/user_settings.dart';
import '../../providers/hydration_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/section_title.dart';
import '../../widgets/surface_card.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _days = 7; // 7 = week, 30 = month

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>().settings;
    final hydration = context.watch<HydrationProvider>();
    final unit = settings.unit;
    final goal = settings.baseGoalMl;

    final history = hydration.history(_days, goal);
    final totals = history.map((d) => d.effectiveMl).toList();
    final sum = totals.fold(0.0, (a, b) => a + b);
    final avg = sum / _days;
    final daysMet = history.where((d) => d.metGoal).length;
    final completion = (history
                .map((d) =>
                    (goal == 0 ? 0.0 : d.effectiveMl / goal).clamp(0.0, 1.0))
                .fold(0.0, (a, b) => a + b) /
            _days *
            100)
        .round();

    return CustomScrollView(
      slivers: [
        SliverAppBar(pinned: true, title: Text(l.statsTitle)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Range toggle
                SegmentedButton<int>(
                  segments: [
                    ButtonSegment(value: 7, label: Text(l.rangeWeek)),
                    ButtonSegment(value: 30, label: Text(l.rangeMonth)),
                  ],
                  selected: {_days},
                  onSelectionChanged: (s) => setState(() => _days = s.first),
                ),
                const SizedBox(height: 20),

                // Metric grid
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        icon: Icons.show_chart_rounded,
                        color: AppColors.primary,
                        value: Volume.format(avg, unit),
                        label: l.avgIntake,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _MetricCard(
                        icon: Icons.opacity_rounded,
                        color: AppColors.waterBottom,
                        value: Volume.formatLarge(sum, unit),
                        label: l.totalIntake,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        icon: Icons.check_circle_rounded,
                        color: AppColors.success,
                        value: '$daysMet/$_days',
                        label: l.daysMetGoal,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _MetricCard(
                        icon: Icons.percent_rounded,
                        color: AppColors.gold,
                        value: '$completion%',
                        label: l.goalCompletion,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Bar chart
                SurfaceCard(
                  padding: const EdgeInsets.fromLTRB(12, 20, 16, 12),
                  child: SizedBox(
                    height: 220,
                    child: sum <= 0
                        ? Center(
                            child: Text(l.noData,
                                style: theme.textTheme.bodyMedium),
                          )
                        : _IntakeChart(
                            history: history,
                            goalMl: goal,
                            unit: unit,
                          ),
                  ),
                ),
                const SizedBox(height: 24),

                SectionTitle(title: l.intakeByType, emoji: '🍹'),
                const SizedBox(height: 12),
                _IntakeByType(
                  data: hydration.intakeByKind(_days),
                  unit: unit,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _MetricCard({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 10),
          Text(value, style: theme.textTheme.titleLarge),
          Text(label, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}

class _IntakeChart extends StatelessWidget {
  final List<DailyTotal> history;
  final int goalMl;
  final VolumeUnit unit;

  const _IntakeChart({
    required this.history,
    required this.goalMl,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final labelColor = theme.textTheme.labelMedium?.color ?? Colors.grey;

    double disp(num ml) => Volume.toDisplay(ml, unit);
    final goalY = disp(goalMl);
    final maxData =
        history.map((d) => disp(d.effectiveMl)).fold(0.0, (a, b) => a > b ? a : b);
    final maxY = (goalY > maxData ? goalY : maxData) * 1.25 + 1;
    final everyLabel = history.length > 10 ? 5 : 1;

    return BarChart(
      BarChartData(
        maxY: maxY,
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => AppColors.darkSurfaceAlt,
            getTooltipItem: (group, _, rod, _) => BarTooltipItem(
              Volume.format(
                  Volume.fromDisplay(rod.toY, unit).toDouble(), unit),
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        extraLinesData: ExtraLinesData(horizontalLines: [
          HorizontalLine(
            y: goalY,
            color: AppColors.success.withValues(alpha: 0.8),
            strokeWidth: 1.5,
            dashArray: const [6, 4],
          ),
        ]),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 34,
              interval: maxY / 3,
              getTitlesWidget: (v, _) => Text(
                v.round().toString(),
                style: TextStyle(color: labelColor, fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (v, meta) {
                final i = v.toInt();
                if (i < 0 || i >= history.length) return const SizedBox();
                if (i % everyLabel != 0) return const SizedBox();
                final label = history.length <= 7
                    ? DateFormat('E', locale).format(history[i].date)
                    : DateFormat('d', locale).format(history[i].date);
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(label,
                      style: TextStyle(color: labelColor, fontSize: 10)),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (int i = 0; i < history.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: disp(history[i].effectiveMl),
                  width: history.length > 10 ? 6 : 14,
                  borderRadius: BorderRadius.circular(4),
                  color: history[i].metGoal
                      ? AppColors.success
                      : AppColors.primary,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _IntakeByType extends StatelessWidget {
  final Map<DrinkKind, double> data;
  final VolumeUnit unit;

  const _IntakeByType({required this.data, required this.unit});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    if (data.isEmpty) {
      return SurfaceCard(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
            child: Text(l.noData, style: theme.textTheme.bodyMedium)),
      );
    }
    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final max = entries.first.value;

    return SurfaceCard(
      child: Column(
        children: [
          for (final e in entries) ...[
            Row(
              children: [
                Icon(e.key.icon, color: e.key.color, size: 20),
                const SizedBox(width: 10),
                SizedBox(width: 78, child: Text(e.key.label(l))),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: max == 0 ? 0 : e.value / max,
                      minHeight: 8,
                      backgroundColor: e.key.color.withValues(alpha: 0.15),
                      valueColor: AlwaysStoppedAnimation(e.key.color),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(Volume.formatLarge(e.value, unit),
                    style: theme.textTheme.labelLarge),
              ],
            ),
            if (e.key != entries.last.key) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}
