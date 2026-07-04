import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/drink_type.dart';
import '../../../providers/settings_provider.dart';

/// Bottom sheet to pick a drink type + amount.
/// Returns `(amountMl, kind)` or null if cancelled.
class DrinkPickerSheet extends StatefulWidget {
  final String title;
  final int initialAmountMl;
  final DrinkKind initialKind;
  final String confirmLabel;

  const DrinkPickerSheet({
    super.key,
    required this.title,
    required this.confirmLabel,
    this.initialAmountMl = 250,
    this.initialKind = DrinkKind.water,
  });

  static Future<(int, DrinkKind)?> show(
    BuildContext context, {
    required String title,
    required String confirmLabel,
    int initialAmountMl = 250,
    DrinkKind initialKind = DrinkKind.water,
  }) {
    return showModalBottomSheet<(int, DrinkKind)>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => DrinkPickerSheet(
        title: title,
        confirmLabel: confirmLabel,
        initialAmountMl: initialAmountMl,
        initialKind: initialKind,
      ),
    );
  }

  @override
  State<DrinkPickerSheet> createState() => _DrinkPickerSheetState();
}

class _DrinkPickerSheetState extends State<DrinkPickerSheet> {
  static const _presetsMl = [150, 200, 250, 330, 500, 750];

  late DrinkKind _kind = widget.initialKind;
  late int _amountMl = widget.initialAmountMl;
  final _customCtrl = TextEditingController();

  @override
  void dispose() {
    _customCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final unit = context.watch<SettingsProvider>().settings.unit;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 4,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),

          // Selected amount preview.
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_kind.icon, color: _kind.color, size: 30),
                const SizedBox(width: 10),
                Text(
                  Volume.format(_amountMl, unit),
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontSize: 30, color: _kind.color),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(l.selectType, style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: DrinkKind.values.map((k) {
              final selected = k == _kind;
              return ChoiceChip(
                selected: selected,
                onSelected: (_) => setState(() => _kind = k),
                avatar: Icon(k.icon,
                    size: 18,
                    color: selected ? Colors.white : k.color),
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

          Text(l.selectAmount, style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _presetsMl.map((ml) {
              final selected = ml == _amountMl && _customCtrl.text.isEmpty;
              return ChoiceChip(
                selected: selected,
                onSelected: (_) => setState(() {
                  _amountMl = ml;
                  _customCtrl.clear();
                }),
                label: Text(Volume.format(ml, unit)),
                showCheckmark: false,
                selectedColor: theme.colorScheme.primary,
                labelStyle: TextStyle(
                  color: selected
                      ? theme.colorScheme.onPrimary
                      : theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _customCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: '${l.customAmount} (${Volume.unitLabel(unit)})',
              prefixIcon: const Icon(Icons.tune_rounded),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            onChanged: (v) {
              final parsed = int.tryParse(v);
              if (parsed != null && parsed > 0) {
                setState(() => _amountMl = Volume.fromDisplay(parsed, unit));
              }
            },
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _amountMl > 0
                ? () => Navigator.pop(context, (_amountMl, _kind))
                : null,
            icon: const Icon(Icons.check_rounded),
            label: Text(widget.confirmLabel),
          ),
        ],
      ),
    );
  }
}
