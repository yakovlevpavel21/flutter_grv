import 'package:grv/features/categories/domain/entities/product_entity.dart';

class CategoryEntity {
  final int id;
  final String name;
  final Map<int, ProductEntity> products;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.products,
  });

  CategoryEntity copyWith({
    int? id,
    String? name,
    Map<int, ProductEntity>? products
  }) {
    return CategoryEntity(
      id: id ?? this.id, 
      name: name ?? this.name, 
      products: products ?? this.products
    );
  }

  List<ProductEntity> get productsList => products.values.toList();
}