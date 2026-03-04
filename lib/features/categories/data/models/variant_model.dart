import 'package:grv/features/categories/data/models/stock_model.dart';
import 'package:grv/features/categories/domain/entities/variant_entity.dart';

class VariantModel extends VariantEntity {
  VariantModel({
    required super.id, 
    required super.name, 
    required super.partsConsumed, 
    required super.stocks
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    final stocksList = (json['stocks'] as List? ?? [])
        .map((s) => StockModel.fromJson(s))
        .toList();

    return VariantModel(
      id: json['id'], 
      name: json['name'], 
      partsConsumed: json['parts_consumed'], 
      stocks: {for (var s in stocksList) s.id: s}, 
    );
  }
}