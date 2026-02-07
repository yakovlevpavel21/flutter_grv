import 'package:grv/data/dtos/stock.dart';
import 'package:grv/data/mappers/color_mapper.dart';
import 'package:grv/data/models/stock.dart';

extension StockMapper on StockDto {
  Stock toListItem() {
    return Stock(
      built: built,
      packed: packed,
      color: color.toModel(),
    );
  }
}