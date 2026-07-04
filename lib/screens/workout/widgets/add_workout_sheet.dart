import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_colors.dart';
import '../../../core/formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/workout.dart';
import '../../../providers/settings_provider.dart';

/// Bottom sheet to log a training session. Returns
/// `(kind, intensity, minutes)` or null if cancelled.
class AddWorkoutSheet extends StatefulWidget {
  const AddWorkoutSheet({super.key});

  static Future<(WorkoutKind, WorkoutIntensity, int)?> show(
      BuildContext context) {
    return showModalBottomSheet<(WorkoutKind, WorkoutIntensity, int)>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const AddWorkoutSheet(),
    );
  }

  @override
  State<AddWorkoutSheet> createState() => _AddWorkoutSheetState();
}

class _AddWorkoutSheetState extends State<AddWorkoutSheet> {
  WorkoutKind _kind = WorkoutKind.strength;
  WorkoutIntensity _intensity = WorkoutIntensity.medium;
  double _minutes = 45;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>().settings;

    final preview = WorkoutEntry(
      id: 'preview',
      kind: _kind,
      intensity: _intensity,
      durationMin: _minutes.round(),
      time: DateTime.now(),
    );
    final kcal = preview.caloriesFor(settings.weightKg);
    final water = preview.extraWaterMl;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 4,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.addWorkout, style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),

            Text(l.workoutTypeLabel, style: theme.textTheme.labelMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: WorkoutKind.values.map((k) {
                final selected = k == _kind;
                return ChoiceChip(
                  selected: selected,
                  onSelected: (_) => setState(() => _kind = k),
                  avatar: Icon(k.icon,
                      size: 18, color: selected ? Colors.white : k.color),
                  label: Text(k.label(l)),
                  showCheckmark: false,
                  selectedColor: k.color,
                  labelStyle: TextStyle(
                    color: selected
                        ? Colors.white
                        : theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            Text(l.intensity, style: theme.textTheme.labelMedium),
            const SizedBox(height: 8),
            SegmentedButton<WorkoutIntensity>(
              segments: [
                ButtonSegment(
                    value: WorkoutIntensity.low, label: Text(l.intensityLow)),
                ButtonSegment(
                    value: WorkoutIntensity.medium,
                    label: Text(l.intensityMedium)),
                ButtonSegment(
                    value: WorkoutIntensity.high, label: Text(l.intensityHigh)),
              ],
              selected: {_intensity},
              onSelectionChanged: (s) =>
                  setState(() => _intensity = s.first),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Text(l.duration, style: theme.textTheme.labelMedium),
                const Spacer(),
                Text('${_minutes.round()} ${l.minutesShort}',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: _kind.color)),
              ],
            ),
            Slider(
              value: _minutes,
              min: 5,
              max: 180,
              divisions: 35,
              activeColor: _kind.color,
              label: '${_minutes.round()}',
              onChanged: (v) => setState(() => _minutes = v),
            ),
            const SizedBox(height: 8),

            // Live estimate
            Row(
              children: [
                Expanded(
                  child: _EstimateTile(
                    icon: Icons.local_fire_department_rounded,
                    color: AppColors.streak,
                    value: '$kcal',
                    label: l.caloriesLabel,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _EstimateTile(
                    icon: Icons.water_drop_rounded,
                    color: AppColors.primary,
                    value: Volume.format(water, settings.unit),
                    label: l.hydrationBonusTitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => Navigator.pop(
                  context, (_kind, _intensity, _minutes.round())),
              icon: const Icon(Icons.check_rounded),
              label: Text(l.addWorkout),
            ),
          ],
        ),
      ),
    );
  }
}

class _EstimateTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _EstimateTile({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style:
                      theme.textTheme.titleMedium?.copyWith(color: color)),
              Text(label, style: theme.textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
