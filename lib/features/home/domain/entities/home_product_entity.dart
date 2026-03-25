import 'package:grv/features/home/domain/entities/home_table_row_entity.dart';

class HomeProductEntity {
  final String name;
  final List<String> variantNames; // Заголовки колонок вариантов
  final List<HomeTableRowEntity> rows; // Каждая строка — это уникальный цвет
  
  HomeProductEntity({required this.name, required this.variantNames, required this.rows});
}