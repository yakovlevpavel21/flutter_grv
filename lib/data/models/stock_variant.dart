import 'package:equatable/equatable.dart';
import 'package:grv/data/models/color.dart';
import 'package:grv/data/models/variant_product.dart';

class StockVariant extends Equatable {
  final int id;
  final ColorModel color;
  final VariantProduct variant;

  const StockVariant({
    required this.id,
    required this.color,
    required this.variant,
  });

  factory StockVariant.fromJson(Map<String, dynamic> json) {
    return StockVariant(
      id: json['id'],
      color: ColorModel.fromJson(json['color']),
      variant: VariantProduct.fromJson(json['variant']),
    );
  }

  @override
  List<Object?> get props => [id, color, variant];
}