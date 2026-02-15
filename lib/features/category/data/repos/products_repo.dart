import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final supabase = Supabase.instance.client;

  Future<void> createProduct(String name, int categoryId) async {
    await supabase.from('products').insert({
      'name': name,
      'category_id': categoryId,
    });
  }

  Future<void> updateProduct(int id, String name, int categoryId) async {
    await supabase.from('products').update({
      'name': name,
      'category_id': categoryId,
    }).eq('id', id);
  }

  Future<void> deleteProduct(int id) async {
    await supabase.from('products').delete().eq('id', id);
  }
}