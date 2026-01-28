import 'package:equatable/equatable.dart';

class MaterialModel extends Equatable {
  final String id;
  final String name;
  final String unit;
  final double quantity;
  final double minLimit;
  final double? costPrice;
  final String? category;


  const MaterialModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.minLimit,
    this.costPrice,
    this.category,
  });


  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'],
      name: json['name'],
      unit: json['unit'],
      quantity: (json['quantity'] as num).toDouble(),
      minLimit: (json['min_limit'] as num).toDouble(),
      costPrice: json['cost_price'] != null ? (json['cost_price'] as num).toDouble() : null,
      category: json['category'],
    );
  }


  @override
  List<Object?> get props => [id, name, unit, quantity, minLimit, costPrice, category];
}