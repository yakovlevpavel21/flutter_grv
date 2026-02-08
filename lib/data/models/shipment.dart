import 'package:equatable/equatable.dart';
import 'package:grv/data/models/stock_shipments.dart';
import 'package:grv/data/models/shop.dart';

class Shipment extends Equatable {
  final String id;
  final String createdAt;
  final String type;
  final Shop shop;
  final List<StockShipment> stokShipments;

  const Shipment({
    required this.id,
    required this.createdAt,
    required this.type,
    required this.shop,
    required this.stokShipments,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'],
      createdAt: json['created_at'],
      type: json['type'],
      shop: Shop.fromJson(json['shop']),
      stokShipments: (json['stock_shipments'] as List<dynamic>)
          .map((e) => StockShipment.fromJson(e))
          .toList(),
    );
  }


  @override
  List<Object?> get props => [id, createdAt, type, shop, stokShipments];
}