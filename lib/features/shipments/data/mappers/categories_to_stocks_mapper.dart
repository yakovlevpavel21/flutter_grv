import 'package:grv/features/categories/domain/entities/category_entity.dart';
import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/shipments/domain/entities/stock_details_entity.dart';

extension CategoriesToStocksUiMapper on List<CategoryEntity> {
  List<StockDetailsEntity> toStocksUi() {
    final result = <StockDetailsEntity>[];
    for (final c in this){
      for (final p in c.productsList) {
        for (final v in p.variantsList) {
          for (final s in v.stocksList) {
            if (s.state == StockState.packed) {
              result.add(
                StockDetailsEntity(
                  id: s.id, 
                  variantName: v.name, 
                  productName: p.name, 
                  categoryName: c.name, 
                  color: s.color, 
                  quantity: s.quantity
                ),
              );
            }
          }
        }
      }
    }
    return result;
  }
}