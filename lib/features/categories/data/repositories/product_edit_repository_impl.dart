import 'package:grv/features/categories/domain/repositories/product_edit_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductEditRepositoryImpl implements ProductEditRepository{
  final supabase = Supabase.instance.client;

  @override
  Future<void> createProduct({required String name, required int categoryId}) async {
    await supabase.from('products').insert({
      'name': name,
      'category_id': categoryId,
    });
  }

  @override
  Future<void> updateProduct({required int id, required String name, required int categoryId}) async {
    await supabase.from('products').update({
      'name': name,
      'category_id': categoryId,
    }).eq('id', id);
  }

  @override
  Future<void> deleteProduct({required int id}) async {
    await supabase.from('products').delete().eq('id', id);
  }
}