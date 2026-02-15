import 'package:supabase_flutter/supabase_flutter.dart';

class SemiStockRepository {
  final supabase = Supabase.instance.client;

  Future<void> createSemiStock(int quantity, int colorId, int productId) async {
    await supabase.from('semi_stocks').insert({
      'quantity': quantity,
      'color_id': colorId,
      'product_id': productId,
    });
  }

  Future<void> updateSemiStock(int id, int quantity, int colorId) async {
    await supabase.from('semi_stocks').update({
      'quantity': quantity,
      'color_id': colorId,
    }).eq('id', id);
  }

  Future<void> deleteSemiStock(int id) async {
    await supabase.from('semi_stocks').delete().eq('id', id);
  }
}