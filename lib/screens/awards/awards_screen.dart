import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/hydration_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/workout_provider.dart';
import '../../widgets/section_title.dart';
import '../../widgets/surface_card.dart';

class _Badge {
  final IconData icon;
  final Color color;
  final String title;
  final String desc;
  final bool unlocked;
  final String? progress;

  const _Badge({
    required this.icon,
    required this.color,
    required this.title,
    required this.desc,
    required this.unlocked,
    this.progress,
  });
}

class AwardsScreen extends StatelessWidget {
  const AwardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final settings = context.watch<SettingsProvider>().settings;
    final hydration = context.watch<HydrationProvider>();
    final workout = context.watch<WorkoutProvider>();

    final goal = settings.baseGoalMl;
    final current = hydration.currentStreak(goal);
    final best = hydration.bestStreak(goal);
    final lifetime = hydration.lifetimeMl;
    final tracked = hydration.daysTracked;
    final sessions = workout.totalSessions;
    final anyGoalMet = hydration.daysMetGoalIn(365, goal) > 0;
    final maxDaily = hydration
        .history(365, goal)
        .map((d) => d.effectiveMl)
        .fold(0.0, (a, b) => a > b ? a : b);

    final badges = <_Badge>[
      _Badge(
        icon: Icons.emoji_food_beverage_rounded,
        color: AppColors.primary,
        title: l.badgeFirstSipTitle,
        desc: l.badgeFirstSipDesc,
        unlocked: hydration.totalEntries >= 1,
      ),
      _Badge(
        icon: Icons.flag_rounded,
        color: AppColors.success,
        title: l.badgeGoalGetterTitle,
        desc: l.badgeGoalGetterDesc,
        unlocked: anyGoalMet,
      ),
      _Badge(
        icon: Icons.bolt_rounded,
        color: AppColors.streak,
        title: l.badgeStreak3Title,
        desc: l.badgeStreak3Desc,
        unlocked: best >= 3,
        progress: best < 3 ? '$best/3' : null,
      ),
      _Badge(
        icon: Icons.local_fire_department_rounded,
        color: AppColors.streak,
        title: l.badgeStreak7Title,
        desc: l.badgeStreak7Desc,
        unlocked: best >= 7,
        progress: best < 7 ? '$best/7' : null,
      ),
      _Badge(
        icon: Icons.workspace_premium_rounded,
        color: AppColors.gold,
        title: l.badgeStreak30Title,
        desc: l.badgeStreak30Desc,
        unlocked: best >= 30,
        progress: best < 30 ? '$best/30' : null,
      ),
      _Badge(
        icon: Icons.fitness_center_rounded,
        color: AppColors.danger,
        title: l.badgeAthleteTitle,
        desc: l.badgeAthleteDesc,
        unlocked: sessions >= 10,
        progress: sessions < 10 ? '$sessions/10' : null,
      ),
      _Badge(
        icon: Icons.rocket_launch_rounded,
        color: AppColors.gold,
        title: l.badgeOverachieverTitle,
        desc: l.badgeOverachieverDesc,
        unlocked: maxDaily >= goal * 1.5,
      ),
      _Badge(
        icon: Icons.water_drop_rounded,
        color: AppColors.waterBottom,
        title: l.badgeHydratedTitle,
        desc: l.badgeHydratedDesc,
        unlocked: lifetime >= 100000,
        progress: lifetime < 100000
            ? '${(lifetime / 1000).toStringAsFixed(0)}/100 L'
            : null,
      ),
    ];

    return CustomScrollView(
      slivers: [
        SliverAppBar(pinned: true, title: Text(l.awardsTitle)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _Stat(
                        emoji: '🔥',
                        value: '$current',
                        label: l.currentStreak,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Stat(
                        emoji: '🏆',
                        value: '$best',
                        label: l.bestStreak,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _Stat(
                        emoji: '💧',
                        value: Volume.formatLarge(lifetime, settings.unit),
                        label: l.lifetimeWater,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Stat(
                        emoji: '📅',
                        value: '$tracked',
                        label: l.daysTracked,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SectionTitle(title: l.awardsTitle, emoji: '🏅'),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
          sliver: SliverGrid(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.92,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) => _BadgeCard(badge: badges[i]),
              childCount: badges.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;

  const _Stat({
    required this.emoji,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SurfaceCard(
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: theme.textTheme.titleLarge),
                Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final _Badge badge;
  const _BadgeCard({required this.badge});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final unlocked = badge.unlocked;
    final muted = theme.textTheme.labelMedium?.color ?? Colors.grey;

    return SurfaceCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: unlocked
                  ? badge.color.withValues(alpha: 0.18)
                  : muted.withValues(alpha: 0.12),
            ),
            child: Icon(
              unlocked ? badge.icon : Icons.lock_rounded,
              color: unlocked ? badge.color : muted,
              size: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            badge.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              color: unlocked ? null : muted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            badge.desc,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium,
          ),
          const SizedBox(height: 8),
          Text(
            unlocked ? l.unlocked : (badge.progress ?? l.locked),
            style: theme.textTheme.labelMedium?.copyWith(
              color: unlocked ? AppColors.success : muted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
