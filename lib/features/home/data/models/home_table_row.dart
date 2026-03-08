import 'package:grv/features/home/data/models/home_variant_cell.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';

class HomeTableRowUi {
  final int stockRawId;
  final ColorEntity color;
  final int rawCount;
  final List<HomeVariantCellUi> variantCells; // По одной ячейке на каждый вариант из variantNames

  HomeTableRowUi({
    required this.stockRawId, 
    required this.color, 
    required this.rawCount, 
    required this.variantCells
  });
}