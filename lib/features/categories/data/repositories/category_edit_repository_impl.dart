import 'package:grv/features/categories/domain/repositories/category_edit_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryEditRepositoryImpl implements CategoryEditRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createCategory({ required String name }) async {
    await supabase.from('categories').insert({
      'name': name,
    });
  }

  @override
  Future<void> updateCategory({required int id, required String name}) async {
    await supabase.from('categories').update({
      'name': name
    }).eq('id', id);
  }

  @override
  Future<void> deleteCategory({required int id}) async {
    await supabase.from('categories').delete().eq('id', id);
  }
}