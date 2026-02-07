import 'package:equatable/equatable.dart';
import 'package:grv/data/models/product_stocks.dart';

class CategoryProducts extends Equatable {
  final String name;
  final List<ProductStocks> products;

  const CategoryProducts({
    required this.name,
    required this.products,
  });

  @override
  List<Object?> get props => [name, products];
}