import 'package:grv/features/categories/domain/repositories/stock_edit_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StockEditRepositoryImpl implements StockEditRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createStock({
    required int productId, 
    int? variantId, 
    required int colorId, 
    required String state, 
    required int quantity
  }) async {
    await supabase.from('stocks').insert({
      'product_id': productId,
      'variant_id': variantId,
      'color_id': colorId,
      'state': state,
      'quantity': quantity,
    });
  }

  @override
  Future<void> updateStock({
    required int id, 
    required int colorId, 
    required int quantity
  }) async {
    await supabase.from('stocks').update({
      'color_id': colorId,
      'quantity': quantity,
    }).eq('id', id);
  }

  @override
  Future<void> deleteStock({required int id}) async {
    await supabase.from('stocks').delete().eq('id', id);
  }
}