import 'drink_type.dart';

/// A one-tap quick-add button on the home screen.
class FavoriteDrink {
  final String id;
  final int amountMl;
  final DrinkKind kind;

  const FavoriteDrink({
    required this.id,
    required this.amountMl,
    required this.kind,
  });

  FavoriteDrink copyWith({int? amountMl, DrinkKind? kind}) => FavoriteDrink(
        id: id,
        amountMl: amountMl ?? this.amountMl,
        kind: kind ?? this.kind,
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'amountMl': amountMl, 'kind': kind.name};

  factory FavoriteDrink.fromJson(Map<String, dynamic> j) => FavoriteDrink(
        id: j['id'] as String,
        amountMl: (j['amountMl'] as num).toInt(),
        kind: DrinkKindX.fromName(j['kind']),
      );

  /// The four water defaults shown in the screenshot.
  static List<FavoriteDrink> defaults() => const [
        FavoriteDrink(id: 'f150', amountMl: 150, kind: DrinkKind.water),
        FavoriteDrink(id: 'f200', amountMl: 200, kind: DrinkKind.water),
        FavoriteDrink(id: 'f330', amountMl: 330, kind: DrinkKind.water),
        FavoriteDrink(id: 'f500', amountMl: 500, kind: DrinkKind.water),
      ];
}
