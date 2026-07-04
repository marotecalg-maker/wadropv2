import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

/// Circular water gauge with an animated dual-wave fill.
///
/// [progress] is 0..1+ (the fill is clamped to 1, but callers can pass more to
/// show an "over goal" state via [child]).
class WaterGlobe extends StatefulWidget {
  final double progress;
  final double size;
  final Widget child;

  const WaterGlobe({
    super.key,
    required this.progress,
    required this.child,
    this.size = 260,
  });

  @override
  State<WaterGlobe> createState() => _WaterGlobeState();
}

class _WaterGlobeState extends State<WaterGlobe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _wave;

  @override
  void initState() {
    super.initState();
    _wave = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();
  }

  @override
  void dispose() {
    _wave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg = dark ? const Color(0xFF10192B) : const Color(0xFFEAF3FB);

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: dark ? 0.28 : 0.18),
              blurRadius: 40,
              spreadRadius: 2,
            ),
          ],
        ),
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: widget.progress.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (context, level, _) {
            return AnimatedBuilder(
              animation: _wave,
              builder: (context, _) {
                return CustomPaint(
                  painter: _GlobePainter(
                    level: level,
                    phase: _wave.value,
                    background: bg,
                    ring: AppColors.primary,
                  ),
                  child: Center(child: widget.child),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _GlobePainter extends CustomPainter {
  final double level; // 0..1
  final double phase; // 0..1
  final Color background;
  final Color ring;

  _GlobePainter({
    required this.level,
    required this.phase,
    required this.background,
    required this.ring,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.width / 2;

    // Clip everything to the circle so the waves stay inside the globe.
    final clip = Path()..addOval(rect);
    canvas.save();
    canvas.clipPath(clip);

    canvas.drawRect(rect, Paint()..color = background);

    final baseY = size.height * (1 - level);
    final amplitude = size.height * 0.035 * (level <= 0.02 ? 0 : 1);

    // Back wave — lighter, offset phase.
    _drawWave(
      canvas,
      size,
      baseY: baseY,
      amplitude: amplitude * 1.15,
      phaseShift: phase * 2 * math.pi + math.pi * 0.6,
      waves: 1.1,
      paint: Paint()..color = AppColors.waterTop.withValues(alpha: 0.45),
    );

    // Front wave — vertical gradient fill.
    final frontPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.waterTop, AppColors.waterBottom],
      ).createShader(Rect.fromLTWH(0, baseY, size.width, size.height - baseY));
    _drawWave(
      canvas,
      size,
      baseY: baseY,
      amplitude: amplitude,
      phaseShift: phase * 2 * math.pi,
      waves: 1.25,
      paint: frontPaint,
    );

    canvas.restore();

    // Outer ring.
    canvas.drawCircle(
      center,
      radius - 2,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = ring,
    );
  }

  void _drawWave(
    Canvas canvas,
    Size size, {
    required double baseY,
    required double amplitude,
    required double phaseShift,
    required double waves,
    required Paint paint,
  }) {
    final path = Path()..moveTo(0, size.height);
    path.lineTo(0, baseY);
    const step = 3.0;
    for (double x = 0; x <= size.width; x += step) {
      final y = baseY +
          math.sin((x / size.width) * waves * 2 * math.pi + phaseShift) *
              amplitude;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_GlobePainter old) =>
      old.level != level ||
      old.phase != phase ||
      old.background != background ||
      old.ring != ring;
}
