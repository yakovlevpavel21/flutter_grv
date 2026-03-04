import 'package:grv/features/categories/data/models/product_model.dart';
import 'package:grv/features/categories/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.id, required super.name, required super.products});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final productsList = (json['products'] as List? ?? [])
        .map((p) => ProductModel.fromJson(p))
        .toList();

    return CategoryModel(
      id: json['id'],
      name: json['name'],
      products: {for (var p in productsList) p.id: p},
    );
  }
}