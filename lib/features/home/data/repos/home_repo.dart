import 'package:grv/data/dtos/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepository {
  final supabase = Supabase.instance.client;


  Future<List<CategoryDto>> fetchCategories() async {
    final response = await supabase
        .from('categories')
        .select('''
          name,
          products (
            name,
            inventories (
              variant,
              stocks (
                built,
                packed,
                color:colors ( id, name, rgb )
              )
            ),
            semi_stocks (
              quantity,
              color:colors ( id, name, rgb )
            )
          )
        ''');
    print(response);
    return (response as List)
        .map((e) => CategoryDto.fromJson(e))
        .toList();
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