import 'package:equatable/equatable.dart';
import 'package:grv/data/models/product_stocks.dart';

class CategoryProducts extends Equatable {
  final int id;
  final String name;
  final List<ProductStocks> products;

  const CategoryProducts({
    required this.id,
    required this.name,
    required this.products,
  });

  factory CategoryProducts.fromJson(Map<String, dynamic> json) {
    return CategoryProducts(
      id: json['id'],
      name: json['name'],
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductStocks.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, products];
}