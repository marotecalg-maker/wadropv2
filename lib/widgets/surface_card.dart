import 'package:flutter/material.dart';

/// Rounded, bordered container matching the app's card style. Tapable when
/// [onTap] is provided.
class SurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? color;

  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.onLongPress,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardTheme = theme.cardTheme;
    final shape = cardTheme.shape as RoundedRectangleBorder? ??
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
    final radius = shape.borderRadius as BorderRadius;

    return Material(
      color: color ?? cardTheme.color,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: radius,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
