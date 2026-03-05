import 'package:grv/features/shipments/domain/entities/shop_entity.dart';

class ShopModel extends ShopEntity {
  ShopModel({
    required super.id,
    required super.name,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'],
      name: json['name'],
    );
  }
}