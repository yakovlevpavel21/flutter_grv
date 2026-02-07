import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String sku;
  final String? description;
  final String? category;
  final int quantity;
  final double? price;
  final String? imageUrl;


  const Product({
    required this.id,
    required this.name,
    required this.sku,
    this.description,
    this.category,
    required this.quantity,
    this.price,
    this.imageUrl,
  });


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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