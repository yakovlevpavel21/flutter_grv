import 'package:equatable/equatable.dart';

class ProductName extends Equatable {
  final String name;

  const ProductName({
    required this.name,
  });

  factory ProductName.fromJson(Map<String, dynamic> json) {
    return ProductName(
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [name];
}