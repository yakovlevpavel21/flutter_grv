import 'package:grv/features/materials/domain/entities/color_entity.dart';

class StockDetailsEntity {
  final int id;
  final String variantName;
  final String productName;
  final String categoryName;
  final ColorEntity color;
  final int quantity;

  const StockDetailsEntity({
    required this.id,
    required this.variantName,
    required this.productName,
    required this.categoryName,
    required this.color,
    required this.quantity,
  });
}