

import 'package:grv/features/materials/data/models/color_model.dart';
import 'package:grv/features/shipments/domain/entities/stock_details_entity.dart';

class StockDetailsModel extends StockDetailsEntity {
  StockDetailsModel({
    required super.id,
    required super.variantName,
    required super.productName,
    required super.categoryName,
    required super.color,
    required super.quantity,
  });

  factory StockDetailsModel.fromJson(Map<String, dynamic> json) {
    return StockDetailsModel(
      id: json['id'],
      variantName: json['variant']['name'],
      productName: json['product']['name'],
      categoryName: json['product']['category']['name'],
      color: ColorModel.fromJson(json['color']),
      quantity: json['quantity'],
    );
  }
}