import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/settings_provider.dart';
import '../../../providers/steps_provider.dart';
import '../../../widgets/surface_card.dart';

/// Live pedometer card: steps today, walking distance (km) and calories,
/// with a ring toward the daily step goal.
class StepsCard extends StatelessWidget {
  const StepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>().settings;
    final stepsP = context.watch<StepsProvider>();

    final steps = stepsP.todaySteps;
    final goal = settings.dailyStepGoal;
    final progress = goal == 0 ? 0.0 : (steps / goal).clamp(0.0, 1.0);
    final percent = (progress * 100).round();

    final stride = settings.strideMeters;
    final km = stepsP.distanceKm(stride);
    final kcal = stepsP.calories(settings.weightKg, stride);

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('👟', style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(l.stepsTitle, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Goal ring
              SizedBox(
                width: 96,
                height: 96,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 9,
                        strokeCap: StrokeCap.round,
                        backgroundColor:
                            AppColors.primary.withValues(alpha: 0.15),
                        valueColor: const AlwaysStoppedAnimation(
                            AppColors.primary),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.directions_walk_rounded,
                            color: AppColors.primary, size: 22),
                        Text('$percent%',
                            style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _grouped(steps),
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(color: AppColors.primary),
                    ),
                    Text('${l.stepsUnit} · $goal ${l.stepGoalOf}',
                        style: theme.textTheme.labelMedium),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _Mini(
                            icon: Icons.straighten_rounded,
                            color: AppColors.success,
                            value: '${km.toStringAsFixed(2)} km',
                            label: l.walkDistance,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _Mini(
                            icon: Icons.local_fire_department_rounded,
                            color: AppColors.streak,
                            value: '$kcal',
                            label: l.caloriesLabel,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (stepsP.permissionDenied) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => context.read<StepsProvider>().start(),
              icon: const Icon(Icons.directions_walk_rounded, size: 18),
              label: Text(l.enableStepCounter),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 1234 -> "1,234"
  String _grouped(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _Mini extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _Mini({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(value,
              style: theme.textTheme.titleMedium?.copyWith(color: color)),
          Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}
