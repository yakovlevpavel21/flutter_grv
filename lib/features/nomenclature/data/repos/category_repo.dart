import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepository {
  final supabase = Supabase.instance.client;

  Future<void> createCategory(String name) async {
    await supabase.from('categories').insert({
      'name': name,
    });
  }

  Future<void> updateCategory(int id, String name) async {
    await supabase.from('categories').update({
      'name': name
    }).eq('id', id);
  }

  Future<void> deleteCategory(int id) async {
    await supabase.from('categories').delete().eq('id', id);
  }
}