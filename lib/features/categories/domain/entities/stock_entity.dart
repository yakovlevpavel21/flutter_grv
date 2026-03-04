import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';

class StockEntity {
  final int id;
  final StockState state;
  final int quantity;
  final ColorEntity color;

  StockEntity({
    required this.id,
    required this.state,
    required this.quantity,
    required this.color,
  });

  StockEntity copyWith({
    int? id,
    StockState? state,
    int? quantity,
    ColorEntity? color,
  }) {
    return StockEntity(
      id: id ?? this.id, 
      state: state ?? this.state, 
      quantity: quantity ?? this.quantity, 
      color: color ?? this.color, 
    );
  }
}