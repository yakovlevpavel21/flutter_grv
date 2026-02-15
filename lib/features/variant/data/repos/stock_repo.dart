import 'package:supabase_flutter/supabase_flutter.dart';

class StockRepository {
  final supabase = Supabase.instance.client;

  Future<void> createStock(int variantId, int colorId, int built, int packed) async {
    await supabase.from('stocks').insert({
      'variant_id': variantId,
      'color_id': colorId,
      'built': built,
      'packed': packed,
    });
  }

  Future<void> updateStock(int id, int built, int packed) async {
    await supabase.from('stocks').update({
      'built': built,
      'packed': packed,
    }).eq('id', id);
  }

  Future<void> deleteStock(int id) async {
    await supabase.from('stocks').delete().eq('id', id);
  }
}