import 'package:grv/features/shipments/data/models/shipment_model.dart';
import 'package:grv/features/shipments/domain/entities/shipment_entity.dart';
import 'package:grv/features/shipments/domain/repositories/shipments_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShipmentsRepositoryImpl implements ShipmentsRepository{
  final supabase = Supabase.instance.client;

  @override
  Future<List<ShipmentEntity>> getShipments() async {
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
            id,
            variant:variants (name),
            product:products (
              name,
              category:categories (name)
            ),
            color:colors (id, name, rgb),
            quantity
          )
        )
      ''');
    return (response as List).map((e) => ShipmentModel.fromJson(e)).toList();
  }
}