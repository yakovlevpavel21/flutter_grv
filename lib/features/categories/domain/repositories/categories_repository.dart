import 'package:grv/features/categories/domain/entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<List<CategoryEntity>> getCategories();
}