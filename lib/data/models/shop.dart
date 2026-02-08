import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  final int id;
  final String name;

  const Shop({
    required this.id,
    required this.name,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}