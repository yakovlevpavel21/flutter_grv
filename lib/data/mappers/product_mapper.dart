import 'package:grv/data/dtos/product.dart';
import 'package:grv/data/mappers/inventory_mapper.dart';
import 'package:grv/data/mappers/semi_stock_mapper.dart';
import 'package:grv/data/models/product_stocks.dart';

extension ProductMapper on ProductDto {
  ProductStocks toListItem() {
    return ProductStocks(
      name: name,
      inventories: inventories.map((e) => e.toListItem()).toList(),
      semiStocks: semiStocks.map((e) => e.toListItem()).toList(),
    );
  }
}