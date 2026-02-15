import 'package:grv/features/category/data/models/product_item.dart';

class CategoryItemUi {
  final int id;
  final String name;
  final Map<int, ProductItemUi> products;

  CategoryItemUi({
    required this.id,
    required this.name,
    required this.products,
  });

  CategoryItemUi copyWith({
    int? id,
    String? name,
    Map<int, ProductItemUi>? products
  }) {
    return CategoryItemUi(
      id: id ?? this.id, 
      name: name ?? this.name, 
      products: products ?? this.products
    );
  }

  List<ProductItemUi> get productsList => products.values.toList();
}