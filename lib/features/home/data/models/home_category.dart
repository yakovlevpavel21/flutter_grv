import 'package:grv/features/home/data/models/home_product.dart';

class HomeCategoryUi {
  final String name;
  final List<HomeProductUi> products;

  HomeCategoryUi({
    required this.name,
    required this.products,
  });
}