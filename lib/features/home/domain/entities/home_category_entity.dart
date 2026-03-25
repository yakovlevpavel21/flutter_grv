import 'package:grv/features/home/domain/entities/home_product_entity.dart';

class HomeCategoryEntity {
  final String name;
  final List<HomeProductEntity> products;
  HomeCategoryEntity({required this.name, required this.products});
}