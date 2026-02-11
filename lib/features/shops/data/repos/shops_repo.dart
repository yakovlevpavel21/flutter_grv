import 'package:grv/data/models/shop.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShopsRepository {
  final supabase = Supabase.instance.client;

  Future<List<Shop>> fetchShops() async {
    final response = await supabase
      .from('shops')
      .select('id, name');
    return (response as List).map((e) => Shop.fromJson(e)).toList();
  }
  
  Future<void> createShop({
    required String name,
    required String sku,
    String? category,
    String? description,
  }) async {
    await supabase.from('products').insert({
      'name': name,
      'sku': sku,
      'category': category,
      'description': description,
    });
  }

  Future<void> updateShop({
    required String id,
    required String name,
    required String sku,
    String? category,
    String? description,
  }) async {
    await supabase.from('products').update({
      'name': name,
      'sku': sku,
      'category': category,
      'description': description,
    }).eq('id', id);
  }

  Future<void> deleteProduct(String id) async {
    await supabase.from('products').delete().eq('id', id);
  }
}