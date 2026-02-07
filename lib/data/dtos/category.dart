import 'package:equatable/equatable.dart';
import 'package:grv/data/dtos/product.dart';

class CategoryDto extends Equatable {
  final String name;
  final List<ProductDto> products;

  const CategoryDto({
    required this.name,
    required this.products,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      name: json['name'],
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductDto.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [name, products];
}