import 'package:equatable/equatable.dart';
import 'package:grv/data/models/product_name.dart';

class InventoryProduct extends Equatable {
  final String variant;
  final ProductName product;

  const InventoryProduct({
    required this.variant,
    required this.product,
  });

  factory InventoryProduct.fromJson(Map<String, dynamic> json) {
    return InventoryProduct(
      variant: json['variant'],
      product: ProductName.fromJson(json['product']),
    );
  }

  @override
  List<Object?> get props => [variant, product];
}