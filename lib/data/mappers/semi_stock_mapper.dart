import 'package:grv/data/dtos/semi_stock.dart';
import 'package:grv/data/mappers/color_mapper.dart';
import 'package:grv/data/models/semi_stock.dart';

extension SemiStockMapper on SemiStockDto {
  SemiStock toListItem() {
    return SemiStock(
      quantity: quantity,
      color: color.toModel(),
    );
  }
}