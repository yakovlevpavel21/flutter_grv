import 'package:equatable/equatable.dart';

class ProductNameDto extends Equatable {
  final String name;


  const ProductNameDto({
    required this.name,
  });


  factory ProductNameDto.fromJson(Map<String, dynamic> json) {
    return ProductNameDto(
      name: json['name'],
    );
  }


  @override
  List<Object?> get props => [name];
}