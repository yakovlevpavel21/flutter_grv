import 'package:grv/features/colors/data/models/color_item.dart';

class StockItemUi {
  final int id;
  final ColorItemUi color;
  final int built;
  final int packed;

  StockItemUi({
    required this.id,
    required this.color,
    required this.built,
    required this.packed,
  });
}