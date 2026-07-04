import '../models/user_settings.dart';

/// Volume conversion + display helpers. Everything is stored internally in
/// millilitres; conversion to ounces happens only at display time.
class Volume {
  Volume._();

  static const double mlPerOz = 29.5735;

  static double toDisplay(num ml, VolumeUnit unit) =>
      unit == VolumeUnit.oz ? ml / mlPerOz : ml.toDouble();

  static int fromDisplay(num value, VolumeUnit unit) =>
      unit == VolumeUnit.oz ? (value * mlPerOz).round() : value.round();

  static String unitLabel(VolumeUnit unit) =>
      unit == VolumeUnit.oz ? 'oz' : 'ml';

  /// e.g. `330 ml` or `11.2 oz`. Set [withUnit] false for just the number.
  static String format(num ml, VolumeUnit unit, {bool withUnit = true}) {
    final value = toDisplay(ml, unit);
    final String number = unit == VolumeUnit.oz
        ? value.toStringAsFixed(value >= 100 ? 0 : 1)
        : value.round().toString();
    return withUnit ? '$number ${unitLabel(unit)}' : number;
  }

  /// Compact litres/gallons for lifetime totals, e.g. `12.4 L`.
  static String formatLarge(num ml, VolumeUnit unit) {
    if (unit == VolumeUnit.oz) {
      final gal = ml / mlPerOz / 128.0;
      return '${gal.toStringAsFixed(1)} gal';
    }
    final l = ml / 1000.0;
    return '${l.toStringAsFixed(l >= 100 ? 0 : 1)} L';
  }
}
