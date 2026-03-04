import 'package:grv/features/home/data/models/home_table_row.dart';

class HomeProductUi {
  final String name;
  final List<String> variantNames; // Заголовки колонок вариантов
  final List<HomeTableRowUi> rows; // Каждая строка — это уникальный цвет
  
  HomeProductUi({required this.name, required this.variantNames, required this.rows});
}