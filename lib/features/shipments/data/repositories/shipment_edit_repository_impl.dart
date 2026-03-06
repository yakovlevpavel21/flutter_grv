import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/domain/entities/stock_shipment_entity.dart';
import 'package:grv/features/shipments/domain/repositories/shipment_edit_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShipmentEditRepositoryImpl implements ShipmentEditRepository{
  final supabase = Supabase.instance.client;
  
  @override
  Future<void> createShipment({
    required DateTime createdAt,
    required int shopId,
    required ShipmentType type,
    required List<StockShipmentEntity> items,
  }) async {
    await supabase.rpc(
      'create_shipment_with_items',
      params: {
        'p_created_at': createdAt.toIso8601String(),
        'p_shop_id': shopId,
        'p_type': type.name,
        'p_items': items.map((e) => {
          'stock_id': e.stock.id,
          'quantity': e.quantity,
        }).toList(),
      }
    );
  }

  @override
  Future<void> deleteShipment({ required int id }) async {
    await supabase.rpc(
      'delete_shipment',
      params: {
        'p_shipment_id': id
      }
    );
  }
}