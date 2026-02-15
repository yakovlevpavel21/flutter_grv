import 'package:supabase_flutter/supabase_flutter.dart';

class VariantRepository {
  final supabase = Supabase.instance.client;

  Future<void> createVariant(String variant, int ratio, int productId) async {
    await supabase.from('variants').insert({
      'name': variant,
      'ratio': ratio,
      'product_id': productId,
    });
  }

  Future<void> updateVariant(int id, String variant, int ratio) async {
    await supabase.from('variants').update({
      'name': variant,
      'ratio': ratio,
    }).eq('id', id);
  }

  Future<void> deleteVariant(int id) async {
    await supabase.from('variants').delete().eq('id', id);
  }
}