import 'package:equatable/equatable.dart';

class ShopDto extends Equatable {
  final int id;
  final int name;

  const ShopDto({
    required this.id,
    required this.name,
  });

  factory ShopDto.fromJson(Map<String, dynamic> json) {
    return ShopDto(
      id: json['id'],
      name: json['name'],
    );
  }


  @override
  List<Object?> get props => [id, name];
}