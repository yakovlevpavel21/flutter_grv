import 'package:grv/features/categories/domain/repositories/variant_edit_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VariantEditRepositoryImpl implements VariantEditRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createVariant({
    required String name, 
    required int partsConsumed, 
    required int productId
  }) async {
    await supabase.from('variants').insert({
      'name': name,
      'parts_consumed': partsConsumed,
      'product_id': productId,
    });
  }

  @override
  Future<void> updateVariant({
    required int id, 
    required String name, 
    required int partsConsumed
  }) async {
    await supabase.from('variants').update({
      'name': name,
      'parts_consumed': partsConsumed,
    }).eq('id', id);
  }

  @override
  Future<void> deleteVariant({required int id}) async {
    await supabase.from('variants').delete().eq('id', id);
  }
}