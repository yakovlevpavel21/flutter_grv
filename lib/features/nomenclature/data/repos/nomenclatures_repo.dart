import 'package:grv/data/models/category_products.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NomenclatureRepository {
  final supabase = Supabase.instance.client;

  Future<List<CategoryProducts>> fetchNomenclature() async {
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
              ratio,
              stocks (
                id,
                built,
                packed,
                color:colors (id, name, rgb)
              )
            ),
            semi_stocks (
              id,
              quantity,
              color:colors (id, name, rgb)
            )
          )
        ''');
    return (response as List)
        .map((e) => CategoryProducts.fromJson(e))
        .toList();
  }
}