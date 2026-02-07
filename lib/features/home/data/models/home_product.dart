import 'package:grv/features/home/data/models/home_table_row.dart';

class HomeProductUi {
  final String name;
  final List<String> variants;
  final List<HomeTableRowUi> rows;

  HomeProductUi({
    required this.name,
    required this.variants,
    required this.rows,
  });
}