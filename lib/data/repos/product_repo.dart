import 'package:grv/data/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final supabase = Supabase.instance.client;


  Future<List<ProductModel>> fetchProducts() async {
    final response = await supabase.from('products').select();
    return (response as List).map((e) => ProductModel.fromJson(e)).toList();
  }


  Future<void> changeProductQuantity({required String productId, required int amount, required String type}) async {
    await supabase.from('shipments').insert({
      'product_id': productId,
      'change_amount': amount,
      'type': type,
      'user_id': supabase.auth.currentUser!.id,
    });
  }

    Future<void> createProduct({
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

  Future<void> updateProduct({
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