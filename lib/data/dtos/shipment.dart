import 'package:equatable/equatable.dart';
import 'package:grv/data/dtos/stock_shipments.dart';
import 'package:grv/data/dtos/shop.dart';

class ShipmentDto extends Equatable {
  final int id;
  final String createdAt;
  final String type;
  final ShopDto shop;
  final List<StockShipmentDto> shipmentProducts;

  const ShipmentDto({
    required this.id,
    required this.createdAt,
    required this.type,
    required this.shop,
    required this.shipmentProducts,
  });

  factory ShipmentDto.fromJson(Map<String, dynamic> json) {
    return ShipmentDto(
      id: json['id'],
      createdAt: json['created_at'],
      type: json['type'],
      shop: ShopDto.fromJson(json['shop']),
      shipmentProducts: (json['stock_shipments'] as List<dynamic>)
          .map((e) => StockShipmentDto.fromJson(e))
          .toList(),
    );
  }


  @override
  List<Object?> get props => [id, createdAt, type, shop, shipmentProducts];
}