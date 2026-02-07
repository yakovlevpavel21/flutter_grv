import 'package:grv/data/models/color.dart';
import 'package:grv/features/home/data/models/home_variant_cell.dart';

class HomeTableRowUi {
  final ColorModel color;
  final int semiFinished;
  final List<HomeVariantCellUi> cells;

  HomeTableRowUi({
    required this.color,
    required this.semiFinished,
    required this.cells,
  });
}