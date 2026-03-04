import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/materials/data/models/color_model.dart';
import 'package:grv/features/categories/domain/entities/stock_entity.dart';

class StockModel extends StockEntity {
  StockModel({
    required super.id, 
    required super.state, 
    required super.quantity,
    required super.color
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'], 
      state: (json['state'] as String).toStockState(), 
      quantity: json['quantity'], 
      color: ColorModel.fromJson(json['color'] as dynamic),
    );
  }
}