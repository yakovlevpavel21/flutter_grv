import 'package:equatable/equatable.dart';
import 'package:grv/data/dtos/stock.dart';

class InventoryDto extends Equatable {
  final String variant;
  final List<StockDto> stocks;


  const InventoryDto({
    required this.variant,
    required this.stocks,
  });


  factory InventoryDto.fromJson(Map<String, dynamic> json) {
    return InventoryDto(
      variant: json['variant'],
      stocks: (json['stocks'] as List<dynamic>)
          .map((e) => StockDto.fromJson(e))
          .toList(),
    );
  }


  @override
  List<Object?> get props => [variant, stocks];
}