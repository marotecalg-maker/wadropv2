import 'package:flutter/material.dart';
import '../../../widgets/surface_card.dart';

/// One of the three summary cards at the top of the home screen.
class StatPill extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final Color? valueColor;

  const StatPill({
    super.key,
    required this.emoji,
    required this.value,
    required this.label,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(color: valueColor),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: theme.textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
