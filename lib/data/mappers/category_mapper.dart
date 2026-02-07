import 'package:grv/data/dtos/category.dart';
import 'package:grv/data/mappers/product_mapper.dart';
import 'package:grv/data/models/category_products.dart';

extension CategoryMapper on CategoryDto {
  CategoryProducts toListItem() {
    return CategoryProducts(
      name: name,
      products: products.map((e) => e.toListItem()).toList(),
    );
  }
}