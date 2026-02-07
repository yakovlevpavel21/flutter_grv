import 'package:equatable/equatable.dart';
import 'package:grv/data/dtos/product_name.dart';

class InventoryProductDto extends Equatable {
  final String variant;
  final ProductNameDto product;


  const InventoryProductDto({
    required this.variant,
    required this.product,
  });


  factory InventoryProductDto.fromJson(Map<String, dynamic> json) {
    return InventoryProductDto(
      variant: json['variant'],
      product: ProductNameDto.fromJson(json['product']),
    );
  }


  @override
  List<Object?> get props => [variant, product];
}