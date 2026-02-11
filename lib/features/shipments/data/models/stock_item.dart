import 'package:equatable/equatable.dart';

class StockItemUi extends Equatable {
  final int id;
  final String color;
  final int packed;
  final String variant;
  final String productName;
  final String categoryName;

  const StockItemUi({
    required this.id,
    required this.color,
    required this.packed,
    required this.variant,
    required this.productName,
    required this.categoryName,
  });

  @override
  List<Object?> get props =>
      [id, color, packed, variant, productName, categoryName];
}