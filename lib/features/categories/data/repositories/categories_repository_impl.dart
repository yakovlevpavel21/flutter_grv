import 'package:grv/features/categories/data/models/category_model.dart';
import 'package:grv/features/categories/domain/entities/category_entity.dart';
import 'package:grv/features/categories/domain/repositories/categories_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoriesRepositoryImpl implements CategoriesRepository{
  final supabase = Supabase.instance.client;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await supabase
        .from('categories')
        .select('''
          id,
          name,
          products (
            id,
            name,
            variants (
              id,
              name,
              parts_consumed,
              stocks (
                id,
                state,
                quantity,
                color:colors (id, name, rgb)
              )
            ),
            stocks (
              id,
              state,
              quantity,
              color:colors (id, name, rgb)
            )
          )
        ''')
        .timeout(Duration(seconds: 5));
    return (response as List)
        .map((categoryJson) => CategoryModel.fromJson(categoryJson))
        .toList();
  }
}