import 'package:flutter/material.dart';

/// A bold section header with an optional emoji and trailing action.
class SectionTitle extends StatelessWidget {
  final String title;
  final String? emoji;
  final Widget? trailing;

  const SectionTitle({
    super.key,
    required this.title,
    this.emoji,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (emoji != null) ...[
          const SizedBox(width: 8),
          Text(emoji!, style: const TextStyle(fontSize: 18)),
        ],
        const Spacer(),
        ?trailing,
      ],
    );
  }
}
