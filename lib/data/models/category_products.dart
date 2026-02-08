import 'package:equatable/equatable.dart';
import 'package:grv/data/models/product_stocks.dart';

class CategoryProducts extends Equatable {
  final String name;
  final List<ProductStocks> products;

  const CategoryProducts({
    required this.name,
    required this.products,
  });

  factory CategoryProducts.fromJson(Map<String, dynamic> json) {
    return CategoryProducts(
      name: json['name'],
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductStocks.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [name, products];
}