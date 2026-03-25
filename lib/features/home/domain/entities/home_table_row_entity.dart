import 'package:grv/features/home/domain/entities/home_variant_cell_entity.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';

class HomeTableRowEntity {
  final int stockRawId;
  final ColorEntity color;
  final int rawCount;
  final List<HomeVariantCellEntity> variantCells; // По одной ячейке на каждый вариант из variantNames

  HomeTableRowEntity({
    required this.stockRawId, 
    required this.color, 
    required this.rawCount, 
    required this.variantCells
  });
}