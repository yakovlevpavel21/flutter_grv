import 'package:equatable/equatable.dart';
import 'package:grv/data/models/product_name.dart';

class VariantProduct extends Equatable {
  final String variant;
  final ProductName product;

  const VariantProduct({
    required this.variant,
    required this.product,
  });

  factory VariantProduct.fromJson(Map<String, dynamic> json) {
    return VariantProduct(
      variant: json['name'],
      product: ProductName.fromJson(json['product']),
    );
  }

  @override
  List<Object?> get props => [variant, product];
}