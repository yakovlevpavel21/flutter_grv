import 'package:grv/data/dtos/inventory.dart';
import 'package:grv/data/mappers/stock_mapper.dart';
import 'package:grv/data/models/inventory_stocks.dart';

extension InventoryMapper on InventoryDto {
  InventoryStocks toListItem() {
    return InventoryStocks(
      variant: variant,
      stocks: stocks.map((e) => e.toListItem()).toList(),
    );
  }
}