import 'package:grv/data/models/shipment.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/data/models/shipment_product.dart';
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
          quantity,
          stock:stocks (
            id,
            color:colors (id, name, rgb),
            inventory:inventories (
              variant,
              product:products (name)
            )
          )
        )
      ''');
    return (response as List).map((e) => Shipment.fromJson(e)).toList();
  }
  
  Future<void> createShipment({
    required DateTime createdAt,
    required int shopId,
    required ShipmentType type,
    required List<ShipmentProductUi> items,
  }) async {
    await supabase.rpc(
      'create_shipment_with_items',
      params: {
        'p_created_at': createdAt.toIso8601String(),
        'p_shop_id': shopId,
        'p_type': type.name,
        'p_items': items.map((e) => {
          'stock_id': e.id,
          'quantity': e.quantity,
        }).toList(),
      }
    );
  }

  Future<void> deleteShipment(String shipmentId) async {
    await supabase.rpc(
      'delete_shipment_with_items',
      params: {
        'p_shipment_id': shipmentId
      }
    );
  }
}