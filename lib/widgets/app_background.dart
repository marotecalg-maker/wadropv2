import 'package:flutter/material.dart';
import '../core/app_colors.dart';

/// Full-screen vertical gradient that adapts to the active brightness.
class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: dark
              ? const [AppColors.darkBgTop, AppColors.darkBgBottom]
              : const [AppColors.lightBgTop, AppColors.lightBgBottom],
        ),
      ),
      child: child,
    );
  }
}
