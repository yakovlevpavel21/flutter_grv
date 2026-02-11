import 'package:grv/data/models/category_products.dart';
import 'package:grv/features/shipments/data/models/shipment_product.dart';
import 'package:grv/features/shipments/data/models/stock_item.dart';

extension CategoriesToProductsUiMapper on List<CategoryProducts> {
  List<ShipmentProductUi> toProductsUi() {
    final result = <ShipmentProductUi>[];
    for (final c in this){
      for (final p in c.products) {
        for (final i in p.inventories) {
          for (final s in i.stocks) {
            result.add(
              ShipmentProductUi(
                id: s.id,
                color: s.color.name,
                quantity: s.packed,
                variant: i.variant,
                productName: p.name,
                maxQuantity: s.packed
              ),
            );
          }
        }
      }
    }
    return result;
  }
}