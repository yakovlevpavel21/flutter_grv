import 'package:grv/data/models/shipment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShipmentsRepository {
  final supabase = Supabase.instance.client;

  Future<List<Shipment>> fetchShipments() async {
    final response = await supabase
      .from('shipments')
      .select('''
        id,
        created_at,
        shop:shops (id, name),
        type,
        stock_shipments (
          id,
          quantity,
          stock:stocks (
            color:colors (id, name, rgb),
            inventory:inventories (
              variant,
              product:products (name)
            )
          )
        )
      ''');
    print(response);
    return (response as List).map((e) => Shipment.fromJson(e)).toList();
  }
  
  Future<void> createShipment({
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