import 'package:equatable/equatable.dart';

class ShopItemUi extends Equatable {
  final int id;
  final String title;
  const ShopItemUi({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props =>
      [id, title];
}