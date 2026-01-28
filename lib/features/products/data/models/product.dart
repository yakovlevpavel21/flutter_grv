import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String sku;
  final String? description;
  final String? category;
  final int quantity;
  final double? price;
  final String? imageUrl;


  const ProductModel({
    required this.id,
    required this.name,
    required this.sku,
    this.description,
    this.category,
    required this.quantity,
    this.price,
    this.imageUrl,
  });


  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      sku: json['sku'] ?? '',
      description: json['description'],
      category: json['category'],
      quantity: json['quantity'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      imageUrl: json['image_url'],
    );
  }


  @override
  List<Object?> get props => [id, name, sku, description, category, quantity, price, imageUrl];
}