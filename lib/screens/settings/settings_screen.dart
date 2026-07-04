import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_settings.dart';
import '../../providers/hydration_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/workout_provider.dart';
import '../../widgets/surface_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final provider = context.watch<SettingsProvider>();
    final s = provider.settings;

    return CustomScrollView(
      slivers: [
        SliverAppBar(pinned: true, title: Text(l.settingsTitle)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
            child: Column(
              children: [
                // ---- Goal & units ----
                _Section(
                  title: l.sectionGoal,
                  children: [
                    _Tile(
                      icon: Icons.flag_rounded,
                      title: l.dailyGoal,
                      trailing: Text(Volume.format(s.baseGoalMl, s.unit),
                          style: _trailingStyle(context)),
                      onTap: () => _editGoal(context, s),
                    ),
                    const _Divider(),
                    _InlineTile(
                      icon: Icons.straighten_rounded,
                      title: l.unit,
                      child: SegmentedButton<VolumeUnit>(
                        segments: [
                          ButtonSegment(
                              value: VolumeUnit.ml, label: Text(l.unitMl)),
                          ButtonSegment(
                              value: VolumeUnit.oz, label: Text(l.unitOz)),
                        ],
                        selected: {s.unit},
                        showSelectedIcon: false,
                        onSelectionChanged: (v) =>
                            provider.setUnit(v.first),
                      ),
                    ),
                  ],
                ),

                // ---- Profile ----
                _Section(
                  title: l.sectionProfile,
                  children: [
                    _Tile(
                      icon: Icons.monitor_weight_rounded,
                      title: l.weight,
                      trailing: Text('${s.weightKg.round()} kg',
                          style: _trailingStyle(context)),
                      onTap: () => _editWeight(context, s),
                    ),
                    const _Divider(),
                    _Tile(
                      icon: Icons.height_rounded,
                      title: l.height,
                      trailing: Text('${s.heightCm.round()} cm',
                          style: _trailingStyle(context)),
                      onTap: () => _editHeight(context, s),
                    ),
                    const _Divider(),
                    _Tile(
                      icon: Icons.directions_walk_rounded,
                      title: l.stepGoal,
                      trailing: Text('${s.dailyStepGoal}',
                          style: _trailingStyle(context)),
                      onTap: () => _editStepGoal(context, s),
                    ),
                    const _Divider(),
                    _InlineTile(
                      icon: Icons.wc_rounded,
                      title: l.gender,
                      child: SegmentedButton<Gender>(
                        segments: [
                          ButtonSegment(
                              value: Gender.male,
                              label: Text(l.genderMale)),
                          ButtonSegment(
                              value: Gender.female,
                              label: Text(l.genderFemale)),
                        ],
                        selected: {
                          s.gender == Gender.female
                              ? Gender.female
                              : Gender.male
                        },
                        showSelectedIcon: false,
                        onSelectionChanged: (v) =>
                            provider.setGender(v.first),
                      ),
                    ),
                    const _Divider(),
                    _InlineTile(
                      icon: Icons.directions_run_rounded,
                      title: l.activityLevel,
                      child: SegmentedButton<ActivityLevel>(
                        segments: [
                          ButtonSegment(
                              value: ActivityLevel.sedentary,
                              label: Text(l.activitySedentary)),
                          ButtonSegment(
                              value: ActivityLevel.moderate,
                              label: Text(l.activityModerate)),
                          ButtonSegment(
                              value: ActivityLevel.active,
                              label: Text(l.activityActive)),
                        ],
                        selected: {s.activityLevel},
                        showSelectedIcon: false,
                        onSelectionChanged: (v) =>
                            provider.setActivityLevel(v.first),
                      ),
                    ),
                    const _Divider(),
                    _Tile(
                      icon: Icons.auto_awesome_rounded,
                      title: l.suggestGoal,
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => _suggestGoal(context, provider),
                    ),
                  ],
                ),

                // ---- Appearance ----
                _Section(
                  title: l.sectionAppearance,
                  children: [
                    _InlineTile(
                      icon: Icons.brightness_6_rounded,
                      title: l.theme,
                      child: SegmentedButton<ThemeMode>(
                        segments: [
                          ButtonSegment(
                              value: ThemeMode.system,
                              icon: const Icon(Icons.brightness_auto_rounded),
                              tooltip: l.themeSystem),
                          ButtonSegment(
                              value: ThemeMode.light,
                              icon: const Icon(Icons.light_mode_rounded),
                              tooltip: l.themeLight),
                          ButtonSegment(
                              value: ThemeMode.dark,
                              icon: const Icon(Icons.dark_mode_rounded),
                              tooltip: l.themeDark),
                        ],
                        selected: {s.themeMode},
                        showSelectedIcon: false,
                        onSelectionChanged: (v) =>
                            provider.setThemeMode(v.first),
                      ),
                    ),
                    const _Divider(),
                    _Tile(
                      icon: Icons.language_rounded,
                      title: l.language,
                      trailing: Text(_languageLabel(l, s.localeCode),
                          style: _trailingStyle(context)),
                      onTap: () => _editLanguage(context, provider),
                    ),
                  ],
                ),

                // ---- Reminders ----
                _Section(
                  title: l.sectionReminders,
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      secondary:
                          const Icon(Icons.notifications_active_rounded),
                      title: Text(l.enableReminders),
                      value: s.remindersEnabled,
                      onChanged: provider.setRemindersEnabled,
                    ),
                    if (s.remindersEnabled) ...[
                      const _Divider(),
                      _InlineTile(
                        icon: Icons.timelapse_rounded,
                        title: l.reminderInterval,
                        child: DropdownButton<int>(
                          value: s.reminderIntervalHours,
                          underline: const SizedBox(),
                          items: [
                            for (int h = 1; h <= 6; h++)
                              DropdownMenuItem(
                                  value: h,
                                  child: Text('$h ${l.hoursShort}')),
                          ],
                          onChanged: (h) {
                            if (h != null) provider.setReminderInterval(h);
                          },
                        ),
                      ),
                      const _Divider(),
                      _Tile(
                        icon: Icons.schedule_rounded,
                        title: l.activeHours,
                        trailing: Text(
                          '${_hh(s.activeFromHour)} – ${_hh(s.activeToHour)}',
                          style: _trailingStyle(context),
                        ),
                        onTap: () => _editActiveHours(context, provider, s),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(l.remindersNote,
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    ],
                  ],
                ),

                // ---- Data ----
                _Section(
                  title: l.sectionData,
                  children: [
                    _Tile(
                      icon: Icons.restart_alt_rounded,
                      title: l.resetToday,
                      onTap: () =>
                          context.read<HydrationProvider>().resetToday(),
                    ),
                    const _Divider(),
                    _Tile(
                      icon: Icons.delete_forever_rounded,
                      iconColor: AppColors.danger,
                      title: l.clearAllData,
                      titleColor: AppColors.danger,
                      onTap: () => _clearAll(context),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Text('${l.appName} · ${l.version} 1.0.0',
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 4),
                Text(l.madeWith,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextStyle? _trailingStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .titleMedium
      ?.copyWith(color: AppColors.primary);

  String _hh(int hour) => '${hour.toString().padLeft(2, '0')}:00';

  String _languageLabel(AppLocalizations l, String? code) => switch (code) {
        'en' => 'English',
        'fr' => 'Français',
        'ar' => 'العربية',
        _ => l.themeSystem,
      };

  // ---- Dialogs --------------------------------------------------------------

  Future<void> _editGoal(BuildContext context, UserSettings s) async {
    final provider = context.read<SettingsProvider>();
    double value = s.baseGoalMl.toDouble();
    final l = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(l.dailyGoal),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Volume.format(value, s.unit),
                  style: Theme.of(ctx).textTheme.headlineMedium),
              Slider(
                value: value,
                min: 500,
                max: 5000,
                divisions: 90,
                label: value.round().toString(),
                onChanged: (v) => setLocal(() => value = v),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
            FilledButton(
              onPressed: () {
                provider.setGoal(value.round());
                Navigator.pop(ctx);
              },
              child: Text(l.save),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editWeight(BuildContext context, UserSettings s) async {
    final provider = context.read<SettingsProvider>();
    double value = s.weightKg;
    final l = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(l.weight),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${value.round()} kg',
                  style: Theme.of(ctx).textTheme.headlineMedium),
              Slider(
                value: value,
                min: 30,
                max: 200,
                divisions: 170,
                label: value.round().toString(),
                onChanged: (v) => setLocal(() => value = v),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
            FilledButton(
              onPressed: () {
                provider.setWeight(value);
                Navigator.pop(ctx);
              },
              child: Text(l.save),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editHeight(BuildContext context, UserSettings s) async {
    final provider = context.read<SettingsProvider>();
    double value = s.heightCm;
    final l = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(l.height),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${value.round()} cm',
                  style: Theme.of(ctx).textTheme.headlineMedium),
              Slider(
                value: value,
                min: 120,
                max: 220,
                divisions: 100,
                label: value.round().toString(),
                onChanged: (v) => setLocal(() => value = v),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
            FilledButton(
              onPressed: () {
                provider.setHeight(value);
                Navigator.pop(ctx);
              },
              child: Text(l.save),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editStepGoal(BuildContext context, UserSettings s) async {
    final provider = context.read<SettingsProvider>();
    double value = s.dailyStepGoal.toDouble();
    final l = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(l.stepGoal),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${value.round()}',
                  style: Theme.of(ctx).textTheme.headlineMedium),
              Slider(
                value: value,
                min: 1000,
                max: 30000,
                divisions: 29,
                label: value.round().toString(),
                onChanged: (v) => setLocal(() => value = v),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
            FilledButton(
              onPressed: () {
                provider.setStepGoal(value.round());
                Navigator.pop(ctx);
              },
              child: Text(l.save),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _suggestGoal(
      BuildContext context, SettingsProvider provider) async {
    final l = AppLocalizations.of(context);
    final suggestion = provider.settings.suggestedGoalMl;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.suggestGoal),
        content: Text(
            l.suggestedGoalMsg(Volume.format(suggestion, provider.settings.unit))),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
          FilledButton(
            onPressed: () {
              provider.setGoal(suggestion);
              Navigator.pop(ctx);
            },
            child: Text(l.apply),
          ),
        ],
      ),
    );
  }

  Future<void> _editLanguage(
      BuildContext context, SettingsProvider provider) async {
    final l = AppLocalizations.of(context);
    final current = provider.settings.localeCode;
    final options = <String?, String>{
      null: l.themeSystem,
      'en': 'English',
      'fr': 'Français',
      'ar': 'العربية',
    };
    await showDialog<void>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(l.language),
        children: [
          RadioGroup<String?>(
            groupValue: current,
            onChanged: (v) {
              provider.setLocale(v);
              Navigator.pop(ctx);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.entries
                  .map((e) => RadioListTile<String?>(
                        value: e.key,
                        title: Text(e.value),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editActiveHours(
      BuildContext context, SettingsProvider provider, UserSettings s) async {
    final from = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: s.activeFromHour, minute: 0),
      helpText: AppLocalizations.of(context).from,
    );
    if (from == null || !context.mounted) return;
    final to = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: s.activeToHour, minute: 0),
      helpText: AppLocalizations.of(context).to,
    );
    if (to == null) return;
    await provider.setActiveHours(from.hour, to.hour);
  }

  Future<void> _clearAll(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final hydration = context.read<HydrationProvider>();
    final workout = context.read<WorkoutProvider>();
    final settings = context.read<SettingsProvider>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.clearConfirmTitle),
        content: Text(l.clearConfirmMsg),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await hydration.clearAll();
    await workout.clearAll();
    await settings.resetToDefaults();
  }
}

// ---- Layout helpers ---------------------------------------------------------

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    letterSpacing: 1, fontWeight: FontWeight.w700)),
          ),
          SurfaceCard(child: Column(children: children)),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final Color? titleColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _Tile({
    required this.icon,
    required this.title,
    this.iconColor,
    this.titleColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: titleColor)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

/// A tile whose control (segmented button, dropdown…) sits below the label so
/// wide controls don't overflow on narrow screens.
class _InlineTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _InlineTile({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 16),
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: child),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      Divider(height: 1, color: Theme.of(context).dividerColor);
}
