import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core/date_x.dart';
import '../services/storage_service.dart';

/// Reads the device step-counter sensor and exposes *today's* step count.
///
/// The hardware sensor reports steps cumulatively since the last reboot, so we
/// keep a per-day baseline in storage and subtract it. Everything is guarded:
/// on unsupported platforms (web/desktop/tests) or when permission is denied,
/// it simply reports 0 without throwing.
class StepsProvider extends ChangeNotifier {
  final StorageService _storage;
  StreamSubscription<StepCount>? _sub;

  int _todaySteps = 0;
  bool _available = false;
  bool _permissionDenied = false;

  StepsProvider(this._storage);

  int get todaySteps => _todaySteps;
  bool get available => _available;
  bool get permissionDenied => _permissionDenied;

  /// Walking distance today, in kilometres, for the given stride length.
  double distanceKm(double strideMeters) => _todaySteps * strideMeters / 1000;

  /// Rough calories burned walking today (~0.55 kcal per kg per km).
  int calories(double weightKg, double strideMeters) =>
      (distanceKm(strideMeters) * weightKg * 0.55).round();

  bool get _isMobile =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  /// Begins listening to the sensor. Safe to call once at startup.
  Future<void> start() async {
    if (!_isMobile) return;
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final status = await Permission.activityRecognition.request();
        if (!status.isGranted) {
          _permissionDenied = true;
          notifyListeners();
          return;
        }
      }
      _sub = Pedometer.stepCountStream.listen(
        _onStep,
        onError: _onError,
        cancelOnError: false,
      );
      _available = true;
      notifyListeners();
    } catch (e) {
      _available = false;
      debugPrint('StepsProvider: pedometer unavailable ($e)');
    }
  }

  void _onStep(StepCount event) {
    final cumulative = event.steps;
    final todayKey = DateTime.now().dayKey;
    final stored = _storage.readMap(StorageService.kSteps);

    int baseline;
    if (stored == null || stored['day'] != todayKey) {
      // First reading of a new day → today starts at zero.
      baseline = cumulative;
      _storage.writeMap(
          StorageService.kSteps, {'day': todayKey, 'baseline': baseline});
    } else {
      baseline = (stored['baseline'] as num).toInt();
      if (cumulative < baseline) {
        // The device rebooted (counter reset) → recalibrate.
        baseline = cumulative;
        _storage.writeMap(
            StorageService.kSteps, {'day': todayKey, 'baseline': baseline});
      }
    }

    final steps = cumulative - baseline;
    _todaySteps = steps < 0 ? 0 : steps;
    _available = true;
    notifyListeners();
  }

  void _onError(Object error) {
    _available = false;
    debugPrint('StepsProvider: step stream error ($error)');
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
